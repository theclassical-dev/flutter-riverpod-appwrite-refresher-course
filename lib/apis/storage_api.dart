import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_twitter_course/constants/constants.dart';
import 'package:riverpod_twitter_course/core/providers.dart';

final storageApiProvider = Provider((ref) {
  return StorageApi(storage: ref.watch(appwriteStorageProvider));
});

class StorageApi {
  final Storage _storage;
  StorageApi({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImage(List<File> files) async {
    List<String> imageLinks = [];
    for (final file in files) {
      final uploadImage = await _storage.createFile(
        bucketId: AppwriteConstants.imagesBucket,
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: file.path,
        ),
      );
      imageLinks.add(AppwriteConstants.imageUrl(uploadImage.$id));
    }
    return imageLinks;
  }
}
