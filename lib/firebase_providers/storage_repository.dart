import 'firebase_providers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_repository.g.dart';

@riverpod
StorageRepository storageRepository(Ref ref) {
  return StorageRepository(
    firebaseStorage: ref.watch(storageProvider),
  );
}

class StorageRepository {
  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;
  final FirebaseStorage _firebaseStorage;

  Future<String> getDownloadUrl(String path) async {
    return await _firebaseStorage.ref(path).getDownloadURL();
  }

  Future<Iterable<String>> listDownloadUrl(String path) async {
    final listResult = await _firebaseStorage.ref(path).listAll();
    return await Future.wait(
      listResult.items.map((e) => e.getDownloadURL()),
    );
  }

  Future<Iterable<String>> listPaths(String path) async {
    final listResult = await _firebaseStorage.ref(path).listAll();
    return listResult.items.map((e) => e.fullPath);
  }
}
