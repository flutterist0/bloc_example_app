import 'package:flutter_api_test/src/features/photo/models/album_photos.dart';

abstract class PhotoRepository{
  Future<List<AlbumPhotos>> getAlbumPhotosById(int albumId);
}