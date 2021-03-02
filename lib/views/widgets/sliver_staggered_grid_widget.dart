import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/image_model.dart';
import 'image_tile_widget.dart';

class SliverStaggeredGridWidget extends StatelessWidget {
  const SliverStaggeredGridWidget(this.imageList, {Key key}) : super(key: key);
  final List<ImageModel> imageList;

  @override
  Widget build(BuildContext context) {
    return SliverStaggeredGrid.countBuilder(
      crossAxisCount: 2,
      staggeredTileBuilder: (index) =>
          staggeredTileBuilder(imageList[index], context),
      itemBuilder: (context, index) => buildImageItemBuilder(imageList[index]),
      itemCount: imageList.length,
    );
  }

  StaggeredTile staggeredTileBuilder(ImageModel image, context) {
    final aspectRatio = image.height / image.width;
    final columnWidth = MediaQuery.of(context).size.width / 2;
    return StaggeredTile.extent(1, aspectRatio * columnWidth);
  }

  Widget buildImageItemBuilder(ImageModel image) {
    return ImageTileWidget(image);
  }
}
