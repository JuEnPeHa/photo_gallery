import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_gallery/consts.dart';
import 'package:photo_gallery/pages/camera/title_description_and_tag_modal_page.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPage({
    super.key,
    required this.cameras,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool cameraLoading = false;

  void changeCamera() async {
    final int cameraIndex =
        widget.cameras.indexOf(_cameraController.description);

    final CameraController previousCamera = _cameraController;
    CameraController? newCamera;

    if (cameraIndex == 0) {
      newCamera = CameraController(
        widget.cameras[1],
        ResolutionPreset.medium,
        enableAudio: false,
      );
    } else {
      newCamera = CameraController(
        widget.cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );
    }

    await previousCamera.dispose();

    _cameraController = newCamera;
    _initializeControllerFuture = _cameraController.initialize();
    if (mounted) {
      setState(() {
        cameraLoading = false;
      });
    }
  }

  Future<String?> takePicture() async {
    try {
      _cameraController.setFlashMode(FlashMode.off);
      final XFile image = await _cameraController.takePicture();
      print(image.path);
      return image.path;
    } catch (e) {
      print(e);
    }
  }

  String pathToBase64(String path) {
    File file = File(path);
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  // Image imageFromBase64String(String base64String) {
  //   return Image.memory(base64Decode(base64String));
  // }

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
    );
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double OneFifthOfScreenHeight =
        MediaQuery.of(context).size.height / 5; // 1/5 of screen height
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a photo'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       changeCamera();
        //     },
        //     icon: const Icon(Icons.flip_camera_ios_outlined),
        //   ),
        // ],
      ),
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (cameraLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: CameraPreview(
                      _cameraController,
                    ),
                    bottom: OneFifthOfScreenHeight,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: OneFifthOfScreenHeight,
                      color: Colors.black.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                cameraLoading = true;
                              });
                              changeCamera();
                            },
                            icon: const Icon(
                              Icons.flip_camera_android,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                cameraLoading = true;
                              });
                              takePicture().then((value) {
                                if (value != null) {
                                  callTakePhotoEventWithBloc(
                                    context: context,
                                    base64Image: pathToBase64(value),
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TitleDescriptionAndtagModalPage(),
                                    ),
                                  );
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton.filled(
                      child: const Text('An error occurred, please try again'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}
