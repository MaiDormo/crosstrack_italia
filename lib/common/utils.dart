import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

Future<Image> getCompressedImage(String imageUrl) async {
  final ByteData imageData =
      await NetworkAssetBundle(Uri.parse(imageUrl)).load("");
  final Uint8List uint8list = imageData.buffer.asUint8List();
  final compressedData = await FlutterImageCompress.compressWithList(
    uint8list,
    minWidth: 300,
    minHeight: 300,
    quality: 75,
  );
  return Image.memory(compressedData);
}
