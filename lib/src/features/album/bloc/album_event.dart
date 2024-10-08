import 'package:equatable/equatable.dart';

sealed class AlbumEvent extends Equatable{
  const AlbumEvent();
  @override
  List<Object> get props => [];
}
class GetAlbums extends AlbumEvent {
  const GetAlbums();
}