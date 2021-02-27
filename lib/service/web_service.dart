import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/image_model.dart';
import '../utils/constants.dart';

class WebService {
  static const Map<String, String> _header = {
    'Authorization': 'Client-ID ${ApiConstants.ACCESS_KEY}'
  };

  Future<List<ImageModel>> getRandomImages({imageCount = 25}) async {
    final _uri = Uri.https(
        ApiConstants.BASE_URL, '/photos/random', {'count': '$imageCount'});
    final response = await http.get(_uri, headers: _header);
    return imageListFromJson(response.body);
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
    Iterable image = json.decode(response.body)['results'];
    return image.map((e) => ImageModel.fromJson(e)).toList();
  }
}
