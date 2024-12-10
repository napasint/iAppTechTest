import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iapp/blocs/price_bloc.dart';
import 'package:iapp/blocs/user_bloc.dart';
import 'package:iapp/blocs/user_state.dart';
import 'package:iapp/screens/home_screen.dart';
import 'package:iapp/screens/api_response_screen.dart';
import 'package:iapp/screens/account_screen.dart';
import 'package:iapp/utils/device_utils.dart';

void main() {
  runApp(
    // Providing PriceBloc to the entire app
    BlocProvider<PriceBloc>(
      create: (context) => PriceBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            final userIds = state.users.map((user) => user.userId).toList();
            return ApiResponseScreen(userIds: userIds);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      const AccountScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = DeviceUtils.getIconSize(context);
    double bottomNavHeight = DeviceUtils.getBottomNavHeight(context);

    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: SizedBox(
            height: bottomNavHeight,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedHome13,
                    color: Colors.white,
                    size: iconSize,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedMenuSquare,
                    color: Colors.white,
                    size: iconSize,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedShoppingBag02,
                    color: Colors.white,
                    size: iconSize,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
