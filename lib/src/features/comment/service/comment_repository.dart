import 'package:flutter_api_test/src/features/comment/model/comments.dart';

abstract class CommentRepository {
  Future<List<Comments>> getCommentsById(int postId);
}
