import 'package:flutter_api_test/src/core/exception/network_error.dart';
import 'package:flutter_api_test/src/features/photo/bloc/photo_event.dart';
import 'package:flutter_api_test/src/features/photo/bloc/photo_state.dart';
import 'package:flutter_api_test/src/features/photo/service/photo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoService _photoService;
  PhotoBloc(this._photoService) : super(PhotoLoading()) {
    on<GetAlbumPhotos>((event, emit) async{
      try {
        emit(PhotoLoading());
        final response = await _photoService.getAlbumPhotosById(event.albumId);
        emit(PhotoComplated(response));
      } on NetworkError catch (e) {
        emit(PhotoError(e.message));
      }
    });
  }
}