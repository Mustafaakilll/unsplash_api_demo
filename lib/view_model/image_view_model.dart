import 'package:flutter/material.dart';
import '../models/image_model.dart';
import '../service/web_service.dart';

class ImageViewModel extends ChangeNotifier {
  final WebService _service = WebService();

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ImageModel> _randomImage;
  List<ImageModel> get randomImages => _randomImage;

  List<ImageModel> _filteredImages = [];
  List<ImageModel> get filteredImages => _filteredImages;

  Future<void> searchImages(keyword) async {
    _isLoading = true;
    _filteredImages = await _service.searchImage(keyword);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getRandomImages([int imageCount]) async {
    _isLoading = true;
    _randomImage = await _service.getRandomImages();
    _isLoading = false;
    notifyListeners();
  }

  void changeSearchState() {
    _isSearch = !_isSearch;
    notifyListeners();
  }
}
