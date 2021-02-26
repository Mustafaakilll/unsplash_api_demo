import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:media_store/media_store.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';
import 'package:unsplash_api_demo/models/image_model.dart';
import 'package:unsplash_api_demo/service/web_service.dart';
import 'package:http/http.dart' as http;

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
              child: PhotoView(imageProvider: NetworkImage(image.urls.small)),
              onLongPress: () async {
                await downloadImage(context, image.links.download).then(
                  (value) => Toast.show(
                      value
                          ? 'İndirme işlemi başarıyla tamamlandı'
                          : 'Yazma izni alınamadı!',
                      context),
                );
                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: Card(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(side: BorderSide.none),
        child: buildCachedNetworkImage(),
      ),
    );
  }

  Future<bool> downloadImage(BuildContext context, imageUrl) async {
    final storagePerm = await Permission.storage.request();
    if (storagePerm.isGranted) {
      Toast.show('İndirme işlemi başlatıldı lütfen bekleyiniz...', context);
      final downloadLink = await WebService.getDownloadLinks(imageUrl);
      final response = await http.get(downloadLink);
      Toast.show('İndirme işlemi Devam Ediyor lütfen bekleyiniz...', context);
      final result =
          await MediaStore.saveImage(Uint8List.fromList(response.bodyBytes));
      print(result);
      return true;
    } else {
      return false;
    }
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

// Widget buildCachedNetworkImage(BuildContext ctx) {
//   return GestureDetector(
//     onTap: () => showDialog(
//       context: ctx,
//       builder: (context) => Builder(
//         builder: (context) => GestureDetector(
//           onTap: () async {
//             await downloadImage(context, '').then((result) => Toast.show(
//                 result
//                     ? 'İndirme işlemi başarıyla tamamlandı'
//                     : 'Yazma izni alınamadı!',
//                 ctx));

//             Navigator.of(context).pop();
//           },
//           child: CachedNetworkImage(
//             progressIndicatorBuilder: (context, url, downloadProgress) {
//               return Center(
//                   child: CircularProgressIndicator(
//                 value: downloadProgress.progress,
//               ));
//             },
//             imageUrl: '',
//           ),
//         ),
//       ),
//     ),
//   );
// }
