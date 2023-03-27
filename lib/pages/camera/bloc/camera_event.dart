part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

/**
 This Event is used to take a picture with the camera
 **/
class CameraTakePictureEvent extends CameraEvent {
  final String base64;
  final DateTime date;
  final String id;

  const CameraTakePictureEvent({
    required this.base64,
    required this.date,
    required this.id,
  });

  @override
  List<Object> get props => [
        base64,
        date,
        id,
      ];
}

/**
 This Event is used to save the title and description of the picture
 **/
class CameraSaveTitleAndDescriptionEvent extends CameraEvent {
  final String title;
  final String description;

  const CameraSaveTitleAndDescriptionEvent({
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [
        title,
        description,
      ];
}

/**
 This Event is used to save the tag of the picture
 But it save the image itself in the database too
 **/
class CameraSaveTagEvent extends CameraEvent {
  final String tag;

  const CameraSaveTagEvent({
    required this.tag,
  });

  @override
  List<Object> get props => [
        tag,
      ];
}

/**
 This Event is used to cancel the picture taking
 **/
class CameraCancelEvent extends CameraEvent {}
