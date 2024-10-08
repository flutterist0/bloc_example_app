import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_api_test/src/core/exception/network_error.dart';
import 'package:flutter_api_test/src/features/post/models/post.dart';
import 'package:flutter_api_test/src/features/post/service/post_repository.dart';

class PostService implements PostRepository {
  final Dio _dio = Dio();

  @override
  Future<List<Post>> getPosts() async {
    const baseUrl = 'https://jsonplaceholder.typicode.com/posts';

    final response = await _dio.get(baseUrl);
    if (response.statusCode == 200) {
      final jsonBody = response.data as List;
      return jsonBody.map((e) => Post.fromJson(e)).toList();
    } else {
      throw NetworkError(response.statusCode.toString(), response.data);
    }
  }
}


