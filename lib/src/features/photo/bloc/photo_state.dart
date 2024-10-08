import 'package:flutter_api_test/src/features/photo/models/album_photos.dart';

abstract class PhotoState {
  const PhotoState();
}

class PhotoLoading extends PhotoState {
  const PhotoLoading();
}

class PhotoComplated extends PhotoState {
  final List<AlbumPhotos> response;
  const PhotoComplated(this.response);
}

class PhotoError extends PhotoState {
  final String message;
  const PhotoError(this.message);
}
