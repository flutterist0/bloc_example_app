import 'package:flutter_api_test/src/core/exception/network_error.dart';
import 'package:flutter_api_test/src/features/album/bloc/album_event.dart';
import 'package:flutter_api_test/src/features/album/bloc/album_state.dart';
import 'package:flutter_api_test/src/features/album/service/album_repository.dart';
import 'package:flutter_api_test/src/features/album/service/album_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumsState> {
  final AlbumService _albumService;
  AlbumBloc(this._albumService) : super(AlbumsLoading()) {
    on<GetAlbums>((event, emit) async{
      try {
        emit(AlbumsLoading());
        final response = await _albumService.getAlbums();
        emit(AlbumsComplated(response));
      } on NetworkError catch (e) {
      emit(AlbumsError(e.message));
      }
    });
  }
}