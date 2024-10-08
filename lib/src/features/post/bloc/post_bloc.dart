import 'package:flutter_api_test/src/core/exception/network_error.dart';
import 'package:flutter_api_test/src/features/post/bloc/post_event.dart';
import 'package:flutter_api_test/src/features/post/bloc/post_state.dart';
import 'package:flutter_api_test/src/features/post/service/post_repository.dart';
import 'package:flutter_api_test/src/features/post/service/post_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostService _postService;

  PostsBloc(this._postService) : super(PostsLoading()) {
    on<GetPosts>((event, emit) async {
      try {
        emit(PostsLoading());
        final data = await _postService.getPosts();
        emit(PostsComplated(data));
      } on NetworkError catch (e) {
        emit(PostError(e.message));
      }
    });
  }
}
