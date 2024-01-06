import 'dart:io';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/firebase_providers/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageFieldNotifier extends StateNotifier<File?> {
  ImageFieldNotifier() : super(null);

  void selectImage(File imageFile) {
    state = imageFile;
  }

  void clearImage() {
    state = null;
  }
}

final imageFieldProvider =
    StateNotifierProvider<ImageFieldNotifier, File?>((ref) {
  return ImageFieldNotifier();
});

Future<void> uploadImage(
  String filePath,
  String trackRegion,
  String trackId,
  WidgetRef ref,
) async {
  try {
    //get the image name from filepath
    String fileName = filePath.split('/').last;

    // Make sure to replace spaces with underscores in the trackRegion
    String formattedTrackRegion =
        trackRegion.replaceAll(' ', '_').toLowerCase();
    String firebasePath = 'tracks/$formattedTrackRegion/$trackId/$fileName';

    await ref.watch(storageProvider).ref(firebasePath).putFile(File(filePath));
  } catch (e) {
    // Handle any errors
    print(e);
  }
}

class ImageField extends StatefulWidget {
  final Track track;
  final Function(String) onChanged;

  ImageField({
    required this.track,
    required this.onChanged,
  });

  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Card(
      color: Theme.of(context).colorScheme.secondary,
      margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 5.0.h),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: Row(
          children: [
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                return ref.watch(imageFieldProvider) == null
                    ? Text(
                        'Inserisci un\'immagine da aggiungere',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Image.file(
                        ref.watch(imageFieldProvider)!,
                        fit: BoxFit.cover,
                      );
              }),
            ),
            Column(
              children: [
                Consumer(builder: (context, ref, child) {
                  return IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        ref
                            .read(imageFieldProvider.notifier)
                            .selectImage(File(pickedFile.path));
                        widget.onChanged(pickedFile.path);
                      }
                    },
                  );
                }),
                Consumer(builder: (context, ref, child) {
                  return IconButton(
                    icon: Icon(
                      Icons.image,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        ref
                            .read(imageFieldProvider.notifier)
                            .selectImage(File(pickedFile.path));
                        widget.onChanged(pickedFile.path);
                      }
                    },
                  );
                }),
                Consumer(builder: (context, ref, child) {
                  return IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: () {
                      ref.read(imageFieldProvider.notifier).clearImage();
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
