import 'dart:convert';

import '../models/image_model.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class WebService {
  static const Map<String, String> _header = {
    'Authorization': 'Client-ID WpbjnncdcRbCPm61FiSIfezqnnELRNGrdd6vC637y-U'
  };

  Future<List<ImageModel>> getRandomImages({imageCount = 25}) async {
    var _uri = Uri.https(
        ApiConstants.BASE_URL, '/photos/random', {'count': '$imageCount'});
    var response = await http.get(_uri, headers: _header);
    return imageListFromJson(response.body);
    // Iterable image = json.decode(response.body);
    // return image.map((e) => ImageModel.fromJson(e)).toList();
  }

  Future<List<ImageModel>> searchImage(String keyword,
      {int imageCount = 25, int page = 1}) async {
    final _uri = Uri.https(ApiConstants.BASE_URL, '/search/photos');
    var response = await http.get(
        '$_uri?query=$keyword&$page=1&$imageCount=30&order_by=popular',
        headers: _header);
    Iterable image = json.decode(response.body)['results'];
    return image.map((e) => ImageModel.fromJson(e)).toList();
  }

  static Future<String> getDownloadLinks(String link) async {
    final response = await http.get(link, headers: _header);
    return json.decode(response.body)['url'];
  }
}
