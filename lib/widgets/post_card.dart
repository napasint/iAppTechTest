import 'package:flutter/material.dart';
import 'package:iapp/utils/device_utils.dart';

class PostCard extends StatelessWidget {
  final int userId;
  final String title;
  final String body;

  const PostCard(
      {super.key,
      required this.title,
      required this.body,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    double fontSize = DeviceUtils.getFontSize(context);
    double headerFontSize = DeviceUtils.getHeaderSize(context);
    double avatarRadiusAPI = DeviceUtils.getAvatarRadiusAPI(context);
    double smallFontSize = DeviceUtils.getSmallFontSize(context);
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(
                  radius: avatarRadiusAPI,
                  backgroundColor: Colors.black,
                  child: Text(
                    'EX',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "User_${userId.toString()}",
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(fontSize: headerFontSize),
            ),
            const SizedBox(height: 8.0),
            Text(
              body,
              style: TextStyle(fontSize: smallFontSize),
            ),
          ],
        ),
      ),
    );
  }
}
