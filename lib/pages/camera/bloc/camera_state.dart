part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  final PictureModel pictureModel;
  const CameraState({
    required this.pictureModel,
  });

  @override
  List<Object> get props => [
        pictureModel,
      ];
}

class CameraInitialState extends CameraState {
  CameraInitialState()
      : super(
          pictureModel: PictureModel(
            id: '',
            title: '',
            description: '',
            base64: '',
            tag: '',
            date: DateTime.now(),
          ),
        );
}

class CameraTakePictureState extends CameraState {
  CameraTakePictureState({
    required PictureModel pictureModel,
  }) : super(
          pictureModel: pictureModel,
        );
}

class CameraSaveTitleAnddescriptionState extends CameraState {
  CameraSaveTitleAnddescriptionState({
    required PictureModel pictureModel,
  }) : super(
          pictureModel: pictureModel,
        );
}

class CameraSaveTagState extends CameraState {
  CameraSaveTagState({
    required PictureModel pictureModel,
  }) : super(
          pictureModel: pictureModel,
        );
}
