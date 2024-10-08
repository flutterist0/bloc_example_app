import 'package:flutter_api_test/src/features/album/models/album.dart';

abstract class AlbumsState{
  const AlbumsState();
}

class AlbumsLoading extends AlbumsState {
  const AlbumsLoading();
}

class AlbumsComplated extends AlbumsState {
  final List<Album> response;
  const AlbumsComplated(this.response);
}

class AlbumsError extends AlbumsState {
  final String message;
  const AlbumsError(this.message);
}