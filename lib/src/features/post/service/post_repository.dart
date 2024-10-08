import 'package:flutter_api_test/src/features/post/models/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
}