import 'package:dio/dio.dart';
import 'package:flutter_api_test/src/core/exception/network_error.dart';
import 'package:flutter_api_test/src/features/album/models/album.dart';
import 'package:flutter_api_test/src/features/photo/models/album_photos.dart';
import 'package:flutter_api_test/src/features/photo/service/photo_repository.dart';

class PhotoService extends PhotoRepository {
  final Dio _dio = Dio();
  @override
  Future<List<AlbumPhotos>> getAlbumPhotosById(int albumId) async{
    final baseUrl = 'https://jsonplaceholder.typicode.com/photos?albumId=$albumId';
    final response = await _dio.get(baseUrl);
    if (response.statusCode==200) {
       final jsonBody = response.data as List;
      return jsonBody.map((e) => AlbumPhotos.fromJson(e)).toList();
    }else{
      throw NetworkError(response.statusCode.toString(), response.data);
    }
  }
  
}