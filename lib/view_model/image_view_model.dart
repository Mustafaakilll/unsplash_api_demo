import 'package:flutter/material.dart';
import '../models/image_model.dart';
import '../service/web_service.dart';

class ImageViewModel extends ChangeNotifier {
  final WebService _service = WebService();
  final TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  set isSearch(bool value) {
    _isSearch = value;
    notifyListeners();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final List<ImageModel> _randomImage = [];
  List<ImageModel> get randomImages => _randomImage;

  final List<ImageModel> _filteredImages = [];
  List<ImageModel> get filteredImages => _filteredImages;

  Future<void> searchImages(keyword, [_currentPage = 1]) async {
    _isLoading = true;
    _filteredImages
        .addAll(await _service.searchImage(keyword, page: _currentPage));
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getRandomImages([int imageCount = 25]) async {
    _isLoading = true;
    _randomImage.addAll(await _service.getRandomImages(imageCount: imageCount));
    _isLoading = false;
    notifyListeners();
  }
}
