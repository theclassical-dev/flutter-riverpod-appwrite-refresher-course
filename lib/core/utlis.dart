import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String getNameFromEmail(String email) {
  return email.split('@')[0];
}

//function for image picking
Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();

  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}
