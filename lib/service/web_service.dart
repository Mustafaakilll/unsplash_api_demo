import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/image_model.dart';
import '../utils/constants.dart';

class WebService {
  static const Map<String, String> _header = {
    'Authorization': 'Client-ID ${ApiConstants.ACCESS_KEY}'
  };

  Future<List<ImageModel>> getRandomImages({imageCount = 25}) async {
    final _queryParams = {'count': '$imageCount'};
    final _uri =
        Uri.https(ApiConstants.BASE_URL, '/photos/random', _queryParams);
    final response = await http.get(_uri, headers: _header);
    Iterable image = json.decode(response.body);
    return image.map((e) => ImageModel.fromJson(e)).toList();
  }

  Future<List<ImageModel>> searchImage(String keyword,
      {int imageCount = 25, int page = 1}) async {
    final _queryParams = {
      'query': '$keyword',
      'page': '$page',
      'per_page': '$imageCount'
    };
    final _uri =
        Uri.https(ApiConstants.BASE_URL, '/search/photos', _queryParams);
    final response = await http.get('$_uri', headers: _header);
    Iterable imageResults = json.decode(response.body)['results'];
    return imageResults.map((e) => ImageModel.fromJson(e)).toList();
  }
}
