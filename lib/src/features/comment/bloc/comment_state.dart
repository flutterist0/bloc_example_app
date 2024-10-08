import 'package:flutter_api_test/src/features/comment/model/comments.dart';
import 'package:flutter_api_test/src/features/post/models/post.dart';

abstract class CommentState {
  const CommentState();
}

class CommentLoading extends CommentState {
  const CommentLoading();
}

class CommentComplated extends CommentState {
  final List<Comments> response;
  const CommentComplated(this.response);
}

class CommentError extends CommentState {
  final String message;
  const CommentError(this.message);
}
