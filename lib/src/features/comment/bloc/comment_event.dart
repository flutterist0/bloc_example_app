import 'package:equatable/equatable.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetComments extends CommentEvent{
  final int postId;
  const GetComments(this.postId);
}