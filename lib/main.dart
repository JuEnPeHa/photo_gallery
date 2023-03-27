import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photo_gallery/consts.dart';
import 'package:photo_gallery/databases/database.dart';
import 'package:photo_gallery/databases/singleton_camera.dart';
import 'package:photo_gallery/modals/modal_tag_choose.dart';
import 'package:photo_gallery/modals/modal_title_and_description.dart';
import 'package:photo_gallery/models/picture_model.dart';
import 'package:photo_gallery/pages/camera/bloc/camera_bloc.dart';
import 'package:photo_gallery/pages/camera/camera_page.dart';
import 'package:photo_gallery/widgets/create_new_tag_expand_button.dart';
import 'package:photo_gallery/widgets/tag_unit_chip_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter().then((_) {
    Hive.registerAdapter(PictureModelAdapter());
    Hive.openBox(HiveBoxName.photoGallery.name).then((_) {
      testCreationRemoveAndUpdateOfPictureModel().then((_) {
        testCreationRemoveAndUpdateOfTags().then((_) {
          singletonCameraDB.initializeCamera().then((_) {
            runApp(const AppState());
          });
        });
      });
    });
  });
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
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

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => openModalChooseTag(context: context),
              child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent[400]!.withOpacity(0.25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt),
                      SizedBox(width: 10),
                      Text('Take new photo'),
                    ],
                  )),
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void openModalChooseTag({required BuildContext context}) {
  // showModalBottomSheet(
  //   context: context,
  //   builder: (context) {
  //     return Container(
  //       height: 200,
  //       child: Column(
  //         children: [
  //           Text('Choose tag'),
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: photoGalleryDatabase.listTag.length,
  //               itemBuilder: (context, index) {
  //                 return Text(photoGalleryDatabase.listTag[index]);
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   },
  // );
  //For Hot Reload need to use Navigator.push in development
  Navigator.push(
    context,
    MaterialPageRoute(
      // builder: (context) => const JustPageScaffold(),
      builder: (context) => CameraPage(
        cameras: singletonCameraDB.cameras,
      ),
    ),
  );
}

class JustPageScaffold extends StatelessWidget {
  const JustPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        body: Center(
          // child: ModalTagChoose(),
          child: ModalTitleAndDescriptionStepper(),
        ),
      ),
    );
  }
}

// class ScaffoldForModal extends StatelessWidget {
//   final Image image; //For backgroung image
//   const ScaffoldForModal({
//     super.key,
//     required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           image,
//           showGeneralDialog(
//             context: context,
//             pageBuilder: pageBuilder,
//           ),
//         ],
//       ),
//     );
//   }
// }
