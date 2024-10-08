import 'package:flutter_api_test/src/features/post/models/post.dart';

abstract class PostsState {
  const PostsState();
}



class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsComplated extends PostsState {
  final List<Post> response;
  const PostsComplated(this.response);
}

class PostError extends PostsState {
  final String message;
  const PostError(this.message);
}
