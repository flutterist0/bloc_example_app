import 'package:equatable/equatable.dart';

sealed class PhotoEvent extends Equatable{
  const PhotoEvent();


  @override
  List<Object> get props => [];
}

class GetAlbumPhotos extends PhotoEvent {
  final int albumId;
  const GetAlbumPhotos(this.albumId);
}