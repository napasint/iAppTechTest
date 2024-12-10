import 'package:flutter/material.dart';
import 'package:iapp/repositories/api_repository.dart';
import 'package:iapp/utils/device_utils.dart';
import 'package:iapp/widgets/post_card.dart';
import 'package:iapp/models/post.dart';

class ApiResponseScreen extends StatelessWidget {
  final List<int> userIds;

  const ApiResponseScreen({super.key, required this.userIds});

  @override
  Widget build(BuildContext context) {
    double toolbarHeight = DeviceUtils.getToolBarHeight(context);
    double fontSize = DeviceUtils.getFontSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'API Responses',
          style: TextStyle(fontSize: fontSize),
        ),
        toolbarHeight: toolbarHeight,
      ),
      body: ListView.builder(
        itemCount: userIds.length,
        itemBuilder: (context, index) {
          final userId = userIds[index];

          return ListTile(
            subtitle: FutureBuilder<List<Post>>(
              future: ApiRepository().fetchPosts(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final posts = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: posts.map((post) {
                      return PostCard(
                        userId: post.userId,
                        title: post.title,
                        body: post.body,
                      );
                    }).toList(),
                  );
                } else {
                  return Text(
                    'No data found',
                    style: TextStyle(fontSize: fontSize),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
