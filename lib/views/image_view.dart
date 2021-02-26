import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_api_demo/utils/styles/style.dart';
import 'package:unsplash_api_demo/views/widgets/image_tile_widget.dart';

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

  Widget _sliverAppBar(context, ImageViewModel viewModel) => SliverAppBar(
        snap: true,
        floating: true,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: viewModel.isSearch
            ? buildsearchTextFormField(viewModel)
            : buildTextField(context),
        actions: [
          viewModel.isSearch
              ? Row(
                  children: [
                    buildSearchIconButton(viewModel),
                    buildCancelIconButton(viewModel),
                  ],
                )
              : buildGoSearchIconButton(viewModel)
        ],
      );

  Widget buildsearchTextFormField(ImageViewModel viewModel) => TextFormField(
        onFieldSubmitted: (value) => viewModel.searchImages(value),
        controller: _searchController,
        autofocus: true,
        decoration:
            buildInputDecoration('Arama', 'İngilizce yazınız!(Örn: Bicycle)'),
      );

  Widget buildTextField(context) => Text(
        AppConstants.TRENDS_TEXT,
        style: Theme.of(context).appBarTheme.titleTextStyle,
      );

  Widget buildSearchIconButton(ImageViewModel viewModel) => IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          viewModel.searchImages(_searchController.text);
        },
      );

  Widget buildCancelIconButton(ImageViewModel viewModel) => IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          viewModel.changeSearchState();
          viewModel.filteredImages.clear();
        },
      );

  Widget buildGoSearchIconButton(ImageViewModel viewModel) => IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          viewModel.changeSearchState();
        },
      );

  Widget _buildSliverPadding(ImageViewModel viewModel, BuildContext context) =>
      SliverPadding(
        padding: EdgeInsets.all(12),
        sliver: viewModel.isLoading
            ? _loadingWidget()
            : _buildsliverStaggeredGrid(viewModel, context),
      );

  Widget _loadingWidget() => SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  Widget _buildsliverStaggeredGrid(
          ImageViewModel viewModel, BuildContext context) =>
      viewModel.isSearch
          ? buildImagesField(viewModel.filteredImages, context)
          : buildImagesField(viewModel.randomImages, context);

  Widget buildImagesField(
          List<ImageModel> filteredImages, BuildContext context) =>
      SliverStaggeredGrid.countBuilder(
        crossAxisCount: 2,
        staggeredTileBuilder: (index) =>
            staggeredTileBuilder(filteredImages[index], context),
        itemBuilder: (context, index) =>
            buildImageItemBuilder(filteredImages[index]),
        itemCount: filteredImages.length,
      );

  StaggeredTile staggeredTileBuilder(ImageModel image, context) {
    final aspectRatio = image.height / image.width;
    final columnWidth = MediaQuery.of(context).size.width / 2;
    return StaggeredTile.extent(1, aspectRatio * columnWidth);
  }

  Widget buildImageItemBuilder(ImageModel image) {
    return ImageTileWidget(image);
  }
}
