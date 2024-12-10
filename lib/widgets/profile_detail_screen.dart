import 'package:flutter/material.dart';
import 'package:iapp/blocs/price_bloc.dart';
import 'package:iapp/blocs/price_event.dart';
import 'package:iapp/blocs/price_state.dart';
import 'package:iapp/blocs/user_bloc.dart';
import 'package:iapp/blocs/user_state.dart';
import 'package:iapp/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iapp/utils/device_utils.dart';

class ProfileDetailScreen extends StatelessWidget {
  final UserProfile profile;

  const ProfileDetailScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    double fontSize = DeviceUtils.getFontSize(context);
    double avatarRadiusInfo = DeviceUtils.getAvatarRadiusInfo(context);
    double iconSize = DeviceUtils.getIconSize(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: iconSize,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: avatarRadiusInfo,
              backgroundColor: Colors.black,
              child: const Text(
                'EX',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 10, 10, 10),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'API',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF121212),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            profile.phone,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Name Text
                  Text(
                    'Name: ${profile.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Address Text
                  Text(
                    'Address: ${profile.address}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Text
                  Text('Email: ${profile.email}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                      )),
                  const SizedBox(height: 20),

                  // Price Selection Section
                  Text('Select Price: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                      )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPriceOption(context, '100', 100, 0, fontSize),
                      _buildPriceOption(context, '200', 200, 1, fontSize),
                      _buildPriceOption(context, '300', 300, 2, fontSize),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceOption(BuildContext context, String label, int price,
      int index, double fontSize) {
    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, state) {
        bool isSelected = false;

        if (state is PriceListUpdated) {
          isSelected = state.selectedIndex == index;
        }

        return GestureDetector(
          onTap: () {
            final userState = context.read<UserBloc>().state;
            if (userState is UserLoaded) {
              final user =
                  userState.users.firstWhere((u) => u.userId == profile.userId);
              context.read<PriceBloc>().add(
                    SelectPriceEvent(
                        user.userId.toString(), user.name, price, index),
                  );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : const Color(0xFF121212),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
              ),
            ),
          ),
        );
      },
    );
  }
}
