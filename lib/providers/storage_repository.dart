import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_repository.g.dart';

@riverpod
StorageRepository storageRepository(StorageRepositoryRef ref) {
  return StorageRepository(
    firebaseStorage: ref.watch(storageProvider),
  );
}

class StorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  Future<String> getDownloadUrl(String path) async {
    final ref = _firebaseStorage.ref(path);
    final downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<Iterable<String>> listDownloadUrl(String path) async {
    final ref = _firebaseStorage.ref(path);
    final listResult = await ref.listAll();
    final downloadUrls = await Future.wait(
      listResult.items.map((e) => e.getDownloadURL()),
    );
    return downloadUrls;
  }

  ///TODO: in case i want to save files in the storage
}
