import 'package:dio/dio.dart';
import 'package:flutter_api_test/src/core/exception/network_error.dart';
import 'package:flutter_api_test/src/features/album/models/album.dart';
import 'package:flutter_api_test/src/features/album/service/album_repository.dart';

class AlbumService extends AlbumRepository {
  final Dio _dio = Dio();

  @override
  Future<List<Album>> getAlbums() async{
    const baseUrl = 'https://jsonplaceholder.typicode.com/albums';
    final response = await _dio.get(baseUrl);
    if (response.statusCode==200) {
      final jsonBody = response.data as List;
      return jsonBody.map((e) => Album.fromJson(e)).toList();
    }else{
      throw NetworkError(response.statusCode.toString(),response.data);
    }
  }
  
}