import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'build_remove_image_field.g.dart';

@riverpod
Map<Image, String> undoImageDelete(UndoImageDeleteRef ref) {
  return ref.watch(imagesPathToBeDeletedProvider.notifier).undo();
}

@riverpod
class ImagesPathToBeDeleted extends _$ImagesPathToBeDeleted {
  @override
  Map<Image, String> build() {
    return {};
  }

  void addEntry(Map<Image, String> entry) {
    state.addAll(entry);
  }

  void removeEntry(Map<Image, String> entry) {
    state.remove(entry);
  }

  Map<Image, String> undo() {
    if (state.isNotEmpty) {
      final lastEntry = state.entries.last;
      state.remove(lastEntry.key);
      return {lastEntry.key: lastEntry.value};
    }
    return {};
  }

  void deleteAll(
    WidgetRef ref,
  ) async {
    await deleteImage(state, ref);
    clearEntries();
  }

  void clearEntries() {
    state.clear();
  }
}

class RemoveImageField extends ConsumerStatefulWidget {
  final Track track;

  const RemoveImageField({required this.track});

  @override
  _RemoveImageFieldState createState() => _RemoveImageFieldState();
}

class _RemoveImageFieldState extends ConsumerState<RemoveImageField>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final imagesMap = ref.watch(allTrackImagesWithPathsProvider(widget.track));
    final imagesPathToBeDeletedNotifier =
        ref.watch(imagesPathToBeDeletedProvider.notifier);
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 5.0.h),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: switch (imagesMap) {
          AsyncData(:final value) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rimuovi immagini',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //undo iconButton
                    Tooltip(
                      message: 'Annulla rimozione',
                      child: IconButton(
                        icon: Icon(
                          Icons.undo,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          final res = imagesPathToBeDeletedNotifier.undo();

                          setState(
                            () {
                              if (res.isNotEmpty) {
                                value.addEntries(
                                  res.entries,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    Image key = value.keys.elementAt(index);
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        key, //key here
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            imagesPathToBeDeletedNotifier
                                .addEntry({key: value[key]!});
                            setState(() {
                              value.remove(key);
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          AsyncError() => const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          _ => Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
        },
      ),
    );
  }
}

Future<void> deleteImage(
  Map<Image, String> imagesToBeDeleted,
  WidgetRef ref,
) async {
  try {
    imagesToBeDeleted.forEach((image, path) async =>
        await ref.watch(storageProvider).ref(path).delete());
  } catch (e) {
    print(e);
  }
}
