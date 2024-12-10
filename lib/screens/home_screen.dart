import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iapp/blocs/price_bloc.dart';
import 'package:iapp/blocs/price_event.dart';
import 'package:iapp/blocs/user_bloc.dart';
import 'package:iapp/blocs/user_event.dart';
import 'package:iapp/blocs/user_state.dart';
import 'package:iapp/models/user.dart';
import 'package:iapp/utils/device_utils.dart';
import 'package:iapp/widgets/profile_detail_screen.dart';
import 'package:iapp/widgets/user_card.dart';

import 'add_user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double fontSize = DeviceUtils.getFontSize(context);
    double toolbarHeight = DeviceUtils.getToolBarHeight(context);
    BlocProvider.of<UserBloc>(context).add(LoadUserDataEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: TextStyle(fontSize: fontSize),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddUserDialog(context, null);
            },
          ),
        ],
        toolbarHeight: toolbarHeight,
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileDetailScreen(profile: user),
                    ),
                  );
                },
                child: UserCard(
                  user: user,
                  onDelete: () {
                    BlocProvider.of<UserBloc>(context)
                        .add(DeleteUserEvent(userId: user.userId));
                    BlocProvider.of<PriceBloc>(context)
                        .add(DeletePriceEvent(userId: user.userId));
                  },
                  onEdit: () {
                    _showAddUserDialog(context, user);
                  },
                ),
              );
            },
          );
        } else if (state is UserError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("No users available."));
        }
      }),
    );
  }

  void _showAddUserDialog(BuildContext context, UserProfile? user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                user == null ? 'Add New User' : 'Edit User',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: AddUserScreen(user: user),
              ),
            ],
          ),
        );
      },
    );
  }
}
