import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/src/features/comment/view/comments_screen.dart';
import 'package:flutter_api_test/src/features/post/bloc/post_bloc.dart';
import 'package:flutter_api_test/src/features/post/bloc/post_event.dart';
import 'package:flutter_api_test/src/features/post/bloc/post_state.dart';
import 'package:flutter_api_test/src/features/post/service/post_repository.dart';
import 'package:flutter_api_test/src/features/post/service/post_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = PostsBloc(PostService());
        bloc.add(GetPosts());
        return bloc;
      },
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: BlocConsumer<PostsBloc, PostsState>(
          listener: (context, state) {
            if (state is PostError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (BuildContext context, state) {
            if (state is PostsLoading) {
              return buildLoading();
            } else if (state is PostsComplated) {
              return buildComplated(state);
            } else {
              return buildError(state);
            }
          },
        ),
      );

  ListView buildComplated(PostsComplated state) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.response.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              trailing: IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CommentsScreen(
                        postId: state.response[index].id!,
                      ),
                    ),
                  );
                },
              ),
              title: Text('${state.response[index].title}'),
              subtitle: Text('${state.response[index].body}'),
            ),
          );
        });
  }

  Center buildError(PostsState state) {
    final error = state as PostError;
    return Center(
      child: Text(error.message),
    );
  }

  Center buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
