import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../models/image_model.dart';
import '../utils/constants.dart';
import '../view_model/image_view_model.dart';

class ImageView extends StatelessWidget {
  ImageView({Key key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageViewModel>(
      builder: (BuildContext context, viewModel, Widget child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _sliverAppBar(context, viewModel),
              _buildSliverPadding(viewModel, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSliverPadding(ImageViewModel viewModel, BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(12),
      sliver: viewModel.isLoading
          ? _loadingWidgets()
          : _buildsliverStaggeredGrid(viewModel, context),
    );
  }

  Widget _buildsliverStaggeredGrid(
      ImageViewModel viewModel, BuildContext context) {
    return viewModel.isSearch
        ? SliverStaggeredGrid.countBuilder(
            crossAxisCount: 2,
            staggeredTileBuilder: (index) =>
                staggeredTileBuilder(viewModel.filteredImages[index], context),
            itemBuilder: (context, index) =>
                buildImageItemBuilder(viewModel.filteredImages[index]),
            itemCount: viewModel.filteredImages.length,
          )
        : SliverStaggeredGrid.countBuilder(
            crossAxisCount: 2,
            staggeredTileBuilder: (index) =>
                staggeredTileBuilder(viewModel.randomImages[index], context),
            itemBuilder: (context, index) =>
                buildImageItemBuilder(viewModel.randomImages[index]),
            itemCount: viewModel.randomImages.length,
          );
  }

  Widget _loadingWidgets() {
    return SliverToBoxAdapter(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _sliverAppBar(context, ImageViewModel viewModel) => SliverAppBar(
        snap: true,
        floating: true,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: viewModel.isSearch
            ? TextFormField(
                onFieldSubmitted: (value) => viewModel.searchImages(value),
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Arama',
                  hintText: 'İngilizce yazınız!(Örn: Bicycle)',
                  border:
                      UnderlineInputBorder(borderSide: BorderSide(width: 16)),
                ),
              )
            : Text(
                AppConstants.TRENDS_TEXT,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
        actions: [
          viewModel.isSearch
              ? Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        viewModel.searchImages(_searchController.text);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        viewModel.changeSearchState();
                        viewModel.filteredImages.clear();
                      },
                    ),
                  ],
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    viewModel.changeSearchState();
                  },
                )
        ],
      );

  Widget buildImageItemBuilder(ImageModel image) {
    return Card(
      child: Image.network(image.urls.small),
    );
  }

  StaggeredTile staggeredTileBuilder(ImageModel image, context) {
    final aspectRatio = image.height / image.width;
    final columnWidth = MediaQuery.of(context).size.width / 2;
    return StaggeredTile.extent(1, aspectRatio * columnWidth);
  }
}
