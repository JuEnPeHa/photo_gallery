import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_gallery/models/picture_model.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitialState()) {
    on<CameraTakePictureEvent>((event, emit) {
      emit(CameraTakePictureState(
        pictureModel: PictureModel(
          id: event.id,
          title: state.pictureModel.title,
          description: state.pictureModel.description,
          base64: event.base64,
          tag: state.pictureModel.tag,
          date: event.date,
        ),
      ));
    });
    on<CameraSaveTitleAndDescriptionEvent>((event, emit) {
      emit(CameraSaveTitleAnddescriptionState(
        pictureModel: PictureModel(
          id: state.pictureModel.id,
          title: event.title,
          description: event.description,
          base64: state.pictureModel.base64,
          tag: state.pictureModel.tag,
          date: state.pictureModel.date,
        ),
      ));
    });
    on<CameraSaveTagEvent>((event, emit) {
      emit(CameraSaveTagState(
        pictureModel: PictureModel(
          id: state.pictureModel.id,
          title: state.pictureModel.title,
          description: state.pictureModel.description,
          base64: state.pictureModel.base64,
          tag: event.tag,
          date: state.pictureModel.date,
        ),
      ));
    });
    on<CameraCancelEvent>((event, emit) {
      emit(CameraInitialState());
    });
  }
}
