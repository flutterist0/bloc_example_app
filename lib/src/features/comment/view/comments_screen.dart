import 'package:flutter/material.dart';
import 'package:flutter_api_test/src/features/comment/bloc/comment_bloc.dart';
import 'package:flutter_api_test/src/features/comment/bloc/comment_event.dart';
import 'package:flutter_api_test/src/features/comment/bloc/comment_state.dart';
import 'package:flutter_api_test/src/features/comment/service/comment_service.dart';
import 'package:flutter_api_test/src/features/comment/widgets/comment_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatefulWidget {
  final int postId;
  const CommentsScreen({super.key, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = CommentBloc(CommentService());
        bloc.add(GetComments(widget.postId!));
        return bloc;
      },
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() => Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body:
            BlocConsumer<CommentBloc, CommentState>(builder: (context, state) {
          if (state is CommentLoading) {
            return buildLoading();
          } else if (state is CommentComplated) {
            return buildComplated(state);
          } else {
            return buildError(state);
          }
        }, listener: (context, state) {
          if (state is CommentError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }),
      );

  ListView buildComplated(CommentComplated state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.response.length,
      itemBuilder: (context, index) {
        final comment = state.response[index];
        return CommentCard(
          name: comment.name!,
          comment: comment.body!,
          email: comment.email!,
        );
      },
    );
  }

  Center buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Center buildError(CommentState state) {
  final error = state as CommentError;
  return Center(
    child: Text(error.message),
  );
}
