import 'package:camera/camera.dart';

class _SingletonCameraDB {
  _SingletonCameraDB._();

  static final _SingletonCameraDB _instance = _SingletonCameraDB._();

  static _SingletonCameraDB get instance => _instance;

  List<CameraDescription> get cameras => _cameras;
  final List<CameraDescription> _cameras = [];

  Future<void> initializeCamera() async {
    _cameras.addAll(await availableCameras());
  }
}

final singletonCameraDB = _SingletonCameraDB.instance;
