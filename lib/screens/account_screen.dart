import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iapp/blocs/price_bloc.dart';
import 'package:iapp/blocs/price_state.dart';
import 'package:iapp/utils/device_utils.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double toolbarHeight = DeviceUtils.getToolBarHeight(context);
    double fontSize = DeviceUtils.getFontSize(context);
    double iconSize = DeviceUtils.getIconSize(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Details',
          style: TextStyle(fontSize: fontSize),
        ),
        toolbarHeight: toolbarHeight,
      ),
      body: BlocBuilder<PriceBloc, PriceState>(
        builder: (context, state) {
          if (state is PriceListUpdated) {
            final accountRecords = state.paymentRecords;

            if (accountRecords.isEmpty) {
              return Center(
                child: Text(
                  'No account recorded yet.',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
              );
            }

            return ListView.builder(
              itemCount: accountRecords.length,
              itemBuilder: (context, index) {
                final record = accountRecords[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.payment,
                      color: Colors.white,
                      size: iconSize,
                    ),
                    title: Text(
                      record['userName'],
                      style: TextStyle(color: Colors.white, fontSize: fontSize),
                    ),
                    trailing: Text(
                      '\$${record['selectedPrice']}',
                      style: TextStyle(
                          color: Colors.greenAccent, fontSize: fontSize),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFF121212),
    );
  }
}
