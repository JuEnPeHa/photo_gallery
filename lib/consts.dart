import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/databases/database.dart';
import 'package:photo_gallery/models/picture_model.dart';
import 'package:photo_gallery/pages/camera/bloc/camera_bloc.dart';

const String appTitle = 'Photo Gallery JEPH';

const List<String> initialListTag = [
  'All',
  'Family',
  'Friends',
  'Work',
  'School',
  'Travel',
  'Food',
  'Sport',
  'Pet',
  'Nature',
  'Other',
];

const List<String> extraTagListForTest = [
  'Extra1',
  'Extra2',
  'Extra3',
  'Extra4',
  'Extra5',
  'Extra6',
  'Extra7',
  'Extra8',
  'Extra9',
  'Extra10',
];

const List<String> initialListIdForTest = [
  'id1',
  'id2',
  'id3',
  'id4',
  'id5',
  'id6',
  'id7',
  'id8',
  'id9',
  'id10',
];

const List<String> extraIdListForTest = [
  'id11',
  'id12',
  'id13',
  'id14',
  'id15',
  'id16',
  'id17',
  'id18',
  'id19',
  'id20',
];

Future<void> testCreationRemoveAndUpdateOfTags() async {
  print('Start testCreationRemoveAndUpdateOfTags()');
  // photoGalleryDatabase.clear();
  await Future.delayed(const Duration(seconds: 1));

  final List<String> _listTag = photoGalleryDatabase.listTag;
  print('listTag: $_listTag');
  for (var element in initialListTag) {
    photoGalleryDatabase.addTag(tag: element);
    await Future.delayed(const Duration(milliseconds: 50));
    print('listTag: ${photoGalleryDatabase.listTag}');
  }

  photoGalleryDatabase.removeTag(tag: 'All');
  await Future.delayed(const Duration(seconds: 1));
  print('listTag: ${photoGalleryDatabase.listTag}');

  photoGalleryDatabase.addTag(tag: 'All');
  await Future.delayed(const Duration(seconds: 1));
  print('listTag: ${photoGalleryDatabase.listTag}');

  for (var element in extraTagListForTest) {
    photoGalleryDatabase.addTag(tag: element);
    await Future.delayed(const Duration(milliseconds: 50));
    print('listTag: ${photoGalleryDatabase.listTag}');
  }

  print('End testCreationRemoveAndUpdateOfTags()');
}

Future<void> testCreationRemoveAndUpdateOfPictureModel() async {
  print('Start testCreationRemoveAndUpdateOfPictureModel()');
  photoGalleryDatabase.clear();
  await Future.delayed(const Duration(seconds: 1));

  final List<PictureModel> _listPhoto = photoGalleryDatabase.listPhoto;
  print('listPhoto: $_listPhoto');
  for (var element in initialListIdForTest) {
    photoGalleryDatabase.addPhoto(id: element);
    await Future.delayed(const Duration(milliseconds: 50));
    print('listPhoto: ${photoGalleryDatabase.listPhoto}');
  }

  photoGalleryDatabase.removePhoto(id: initialListIdForTest[0]);
  await Future.delayed(const Duration(seconds: 1));
  print('listPhoto: ${photoGalleryDatabase.listPhoto}');
  photoGalleryDatabase.addPhoto(id: initialListIdForTest[0]);
  await Future.delayed(const Duration(seconds: 1));
  print('listPhoto: ${photoGalleryDatabase.listPhoto}');
  for (var element in extraIdListForTest) {
    photoGalleryDatabase.addPhoto(id: element);
    await Future.delayed(const Duration(milliseconds: 50));
    print('listPhoto: ${photoGalleryDatabase.listPhoto}');
  }

  print('End testCreationRemoveAndUpdateOfPictureModel()');
}

//CameraTakePictureEvent
void callTakePhotoEventWithBloc({
  required BuildContext context,
  required String base64Image,
}) {
  BlocProvider.of<CameraBloc>(context).add(CameraTakePictureEvent(
    base64: base64Image,
    date: DateTime.now(),
    id: photoGalleryDatabase.nextPhotoId.toString(),
  ));
}

//CameraSaveTitleAndDescriptionEvent
void callSaveTitleAndDescriptionEventWithBloc({
  required BuildContext context,
  required String title,
  required String description,
}) {
  Navigator.of(context).pop();
  BlocProvider.of<CameraBloc>(context).add(CameraSaveTitleAndDescriptionEvent(
    title: title,
    description: description,
  ));
}

//CameraSaveTagEvent
void callSaveTagEventWithBloc({
  required BuildContext context,
  required String tag,
}) {
  Navigator.of(context).pop();
  BlocProvider.of<CameraBloc>(context).add(CameraSaveTagEvent(
    tag: tag,
  ));
}

//CameraCancelEvent
void callCancelEventWithBloc({
  required BuildContext context,
}) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  BlocProvider.of<CameraBloc>(context).add(CameraCancelEvent());
}
