import 'package:flutter/material.dart';
import 'package:photo_gallery/databases/singleton_camera.dart';
import 'package:photo_gallery/models/picture_model.dart';
import 'package:photo_gallery/pages/camera/camera_page.dart';
import 'package:photo_gallery/pages/categories_page.dart';
import 'package:photo_gallery/pages/category_page.dart';
import 'package:photo_gallery/pages/image_page.dart';

void goToTakePicturePage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CameraPage(
        cameras: singletonCameraDB.cameras,
      ),
    ),
  );
}

void goToCategoriesPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CategoriesPage(),
    ),
  );
}

void goToCategoryPage({
  required BuildContext context,
  required String tag,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CategoryPage(
        tag: tag,
      ),
    ),
  );
}

void goToImagePage({
  required BuildContext context,
  required PictureModel photoElement,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ImagePage(
        title: photoElement.title,
        imageBase64: photoElement.base64,
        description: photoElement.description,
        date: photoElement.date,
        tag: photoElement.tag,
        id: photoElement.id,
      ),
    ),
  );
}
