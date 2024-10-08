import 'package:flutter_api_test/src/core/exception/network_error.dart';
import 'package:flutter_api_test/src/features/comment/bloc/comment_event.dart';
import 'package:flutter_api_test/src/features/comment/bloc/comment_state.dart';
import 'package:flutter_api_test/src/features/comment/service/comment_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentService _commentService;
  CommentBloc(this._commentService) : super(CommentLoading()) {
    on<GetComments>((event, emit) async {
      try {
        emit(CommentLoading());
        final data = await _commentService.getCommentsById(event.postId);
        emit(CommentComplated(data));
      } on NetworkError catch (e) {
        emit(CommentError(e.message));
      }
    });
  }
}
