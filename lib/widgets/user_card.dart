import 'package:flutter/material.dart';
import 'package:iapp/models/user.dart';
import 'package:iapp/utils/device_utils.dart';

class UserCard extends StatelessWidget {
  final UserProfile user;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const UserCard({
    super.key,
    required this.user,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = DeviceUtils.getFontSize(context);
    double avatarRadius = DeviceUtils.getAvatarRadius(context);
    double iconSize = DeviceUtils.getIconSize(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1F1F1F), Color(0xFF121212)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: avatarRadius,
          backgroundColor: Colors.blue,
          child: Text(
            'EX',
            style: TextStyle(color: Colors.white, fontSize: fontSize),
          ),
        ),
        title: Text(
          user.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          user.api,
          style: TextStyle(
            color: Colors.white70,
            fontSize: fontSize,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              iconSize: iconSize,
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
            ),
            IconButton(
              iconSize: iconSize,
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDelete(); 
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
