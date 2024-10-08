import 'package:dio/dio.dart';
import 'package:flutter_api_test/src/core/exception/network_error.dart';
import 'package:flutter_api_test/src/features/comment/model/comments.dart';
import 'package:flutter_api_test/src/features/comment/service/comment_repository.dart';

class CommentService implements CommentRepository {
  final Dio _dio = Dio();

  @override
  Future<List<Comments>> getCommentsById(int postId) async {
    final baseUrl =
        'https://jsonplaceholder.typicode.com/comments?postId=$postId';
    final response = await _dio.get(baseUrl);
    if (response.statusCode == 200) {
      final jsonBody = response.data as List;
      return jsonBody.map((e) => Comments.fromJson(e)).toList();
    } else {
      throw NetworkError(response.statusCode.toString(), response.data);
    }
  }
}
