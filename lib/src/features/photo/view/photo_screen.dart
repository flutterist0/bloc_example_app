import 'package:flutter/material.dart';
import 'package:flutter_api_test/src/features/photo/bloc/photo_bloc.dart';
import 'package:flutter_api_test/src/features/photo/bloc/photo_event.dart';
import 'package:flutter_api_test/src/features/photo/bloc/photo_state.dart';
import 'package:flutter_api_test/src/features/photo/service/photo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoScreen extends StatefulWidget {
  final int albumId;
  const PhotoScreen({super.key, required this.albumId});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        final bloc = PhotoBloc(PhotoService());
        bloc.add(GetAlbumPhotos(widget.albumId));
        return bloc;
      },
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
      ),
      body: BlocConsumer<PhotoBloc, PhotoState>(builder: (context, state) {
        if (state is PhotoLoading) {
          return buildLoading();
        } else if (state is PhotoComplated) {
          return buildComplated(state);
        } else {
          return buildError(state);
        }
      }, listener: (context, state) {
        if (state is PhotoError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      }),
    );
  }

  ListView buildComplated(PhotoComplated state) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.response.length,
        itemBuilder: (context, index) {
          final photo = state.response[index];
          Future<void> loadImage() async {
            await precacheImage(NetworkImage(photo.url!), context);
          }
          return FutureBuilder(
            future: loadImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Image.network(photo.url!),
                    SizedBox(height: 8),
                    Text(photo.title!),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        });
  }

  Center buildError(PhotoState state) {
    final error = state as PhotoError;
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
