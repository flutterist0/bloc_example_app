import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/src/features/album/bloc/album_bloc.dart';
import 'package:flutter_api_test/src/features/album/bloc/album_event.dart';
import 'package:flutter_api_test/src/features/album/bloc/album_state.dart';
import 'package:flutter_api_test/src/features/album/service/album_service.dart';
import 'package:flutter_api_test/src/features/photo/view/photo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) {
      final bloc = AlbumBloc(AlbumService());
      bloc.add(GetAlbums());
      return bloc;
      },
      child: buildScaffold(),
      );
  }

  Scaffold buildScaffold() => Scaffold(
    appBar: AppBar(
      title: Text('Albums'),
    ),
    body: BlocConsumer<AlbumBloc,AlbumsState>(builder: (context, state){
      if (state is AlbumsLoading) {
        return buildLoading();
      }else if(state is AlbumsComplated){
        return buildComplated(state);
      }else{
        return buildError(state);
      }
    }, listener: (context,state){
      if(state is AlbumsError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
      }
    }),
  );

  ListView buildComplated(AlbumsComplated state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.response.length,
      itemBuilder: (context,index){
        final album = state.response[index];
        return InkWell(
          onTap: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context)=>PhotoScreen(albumId: album.id!)));
          },
          child: Card(
            child: ListTile(
              title: Text(album.title!),
            ),
          ),
        );
      });
  }

  Center buildLoading() {
    return Center(
        child: CircularProgressIndicator(),
      );
  }
    Center buildError(AlbumsState state) {
    final error = state as AlbumsError;
    return Center(
      child: Text(error.message),
    );
  }
}
