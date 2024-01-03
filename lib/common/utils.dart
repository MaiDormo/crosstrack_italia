import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@immutable
class Utils {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
  }

  static Future<Uint8List> _getCompressedImage(
      String imageUrl, int minHeight, int minWidth) async {
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(imageUrl)).load("");
    final Uint8List uint8list = imageData.buffer.asUint8List();
    final compressedData = await FlutterImageCompress.compressWithList(
      uint8list,
      minHeight: minHeight.h.floor(),
      minWidth: minWidth.w.floor(),
      quality: 85,
    );
    return compressedData;
  }

  static Future<Uint8List> getCompressedImage(String imageUrl) {
    return _getCompressedImage(imageUrl, 300, 400);
  }

  static Future<Uint8List> getCompressedThumbnail(String thumbnailUrl) {
    return _getCompressedImage(thumbnailUrl, 150, 200);
  }
}
