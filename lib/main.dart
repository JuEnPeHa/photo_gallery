import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photo_gallery/helpers/consts.dart';
import 'package:photo_gallery/databases/database.dart';
import 'package:photo_gallery/databases/singleton_camera.dart';
import 'package:photo_gallery/modals/modal_tag_choose.dart';
import 'package:photo_gallery/modals/modal_title_and_description.dart';
import 'package:photo_gallery/models/picture_model.dart';
import 'package:photo_gallery/pages/camera/bloc/camera_bloc.dart';
import 'package:photo_gallery/pages/camera/camera_page.dart';
import 'package:photo_gallery/pages/categories_page.dart';
import 'package:photo_gallery/pages/category_page.dart';
import 'package:photo_gallery/pages/image_page.dart';
import 'package:photo_gallery/pages/my_home_page.dart';
import 'package:photo_gallery/widgets/create_new_tag_expand_button.dart';
import 'package:photo_gallery/widgets/tag_unit_chip_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter().then((_) {
    Hive.registerAdapter(PictureModelAdapter());
    Hive.openBox(HiveBoxName.photoGallery.name).then((_) {
      // photoGalleryDatabase.clearAllPhoto();
      firstTimeCreateFirstTags().then((value) {
        singletonCameraDB.initializeCamera().then((_) {
          runApp(const AppState());
        });
      });
      // testCreationRemoveAndUpdateOfPictureModel().then((_) {
      // testCreationRemoveAndUpdateOfTags().then((_) {
      // });
      // });
    });
  });
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    // log('photoGalleryDatabase.listPhoto: ${photoGalleryDatabase.listPhoto}');

    return BlocProvider(
      create: (context) => CameraBloc(),
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: appTitle),
    );
  }
}

// class JustPageScaffold extends StatelessWidget {
//   const JustPageScaffold({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: const Scaffold(
//         body: Center(
//           // child: ModalTagChoose(),
//           child: ModalTitleAndDescriptionStepper(),
//         ),
//       ),
//     );
//   }
// }

