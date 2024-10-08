import 'package:flutter_api_test/src/features/album/models/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
}