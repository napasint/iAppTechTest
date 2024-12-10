import 'package:dio/dio.dart';
import '../models/post.dart';

class ApiRepository {
  final Dio dio = Dio();

  Future<List<Post>> fetchPosts(int userId) async {
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/posts?userId=$userId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch posts with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }
}
