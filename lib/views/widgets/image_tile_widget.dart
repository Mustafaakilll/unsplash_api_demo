import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:media_store/media_store.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

import '../../models/image_model.dart';

class ImageTileWidget extends StatelessWidget {
  const ImageTileWidget(this.image, {Key key}) : super(key: key);
  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return GestureDetector(
              child: showFullScreenImage(),
              onTap: () => Navigator.pop(context),
              onLongPress: () async {
                await downloadImage(context, image.links.download)
                    .then((value) => showToast(value, context));
                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: buildImageCard(),
    );
  }

  CachedNetworkImage showFullScreenImage() {
    return CachedNetworkImage(
      fit: BoxFit.fitHeight,
      height: double.tryParse(image.height.toString()),
      width: double.tryParse(image.width.toString()),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          buildImageProgressIndicator(downloadProgress),
      imageUrl: image.urls.full,
    );
  }

  Widget buildImageProgressIndicator(downloadProgress) {
    return Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
      ),
    );
  }

  Future<bool> downloadImage(BuildContext context, imageUrl) async {
    final storagePerm = await Permission.storage.request();
    if (storagePerm.isGranted) {
      Toast.show('İndirme işlemi başlatıldı lütfen bekleyiniz...', context);
      final response = await http.get(imageUrl);
      Toast.show('İndirme işlemi Devam Ediyor lütfen bekleyiniz...', context);
      await MediaStore.saveImage(response.bodyBytes);
      return true;
    } else {
      return false;
    }
  }

  void showToast(value, context) {
    return Toast.show(
        value ? 'İndirme işlemi başarıyla tamamlandı' : 'Yazma izni alınamadı!',
        context);
  }

  Widget buildImageCard() {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(side: BorderSide.none),
      child: buildCachedNetworkImage(),
    );
  }

  Widget buildCachedNetworkImage() {
    return CachedNetworkImage(
      imageUrl: image.urls.small,
      placeholder: (context, url) => buildPlaceHolder,
      errorWidget: (context, url, error) => buildErrorWidget,
      fit: BoxFit.fitHeight,
      width: double.tryParse(image.width.toString()),
      height: double.tryParse(image.height.toString()),
    );
  }

  Widget get buildPlaceHolder => Container(color: Colors.grey[200]);

  Widget get buildErrorWidget => Container(
        color: Colors.grey[200],
        child: Center(
          child: Icon(Icons.broken_image_rounded),
        ),
      );
}
