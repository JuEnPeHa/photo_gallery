import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_gallery/models/picture_model.dart';

enum HiveBoxName {
  photoGallery,
}

enum _Database {
  listPhoto,
  listTag,
  boolFirstTime,
  // listTagWithItem,
}

extension FileToBase64 on File {
  String get parseToBase64 {
    final Uint8List v = this.readAsBytesSync();
    print('v: $v');
    print('parseToBase64: ${base64Encode(v)}' + this.path);
    return base64Encode(v);
  }
}

extension Base64ToFile on String {
  File get parseBase64ToFile => File.fromRawPath(base64Decode(this));
}

class _PhotoGalleryDatabase {
  _PhotoGalleryDatabase._();
  static final _PhotoGalleryDatabase _instance = _PhotoGalleryDatabase._();
  static _PhotoGalleryDatabase get instance => _instance;

  static final Box _box = Hive.box(HiveBoxName.photoGallery.name);

  List<PictureModel> get listPhoto {
    final List<PictureModel> _listPhoto = _box.get(_Database.listPhoto.name,
        defaultValue: <PictureModel>[]).cast<PictureModel>();
    return _listPhoto;
  }

  int get nextPhotoId {
    final List<PictureModel> _listPhoto = listPhoto;
    return _listPhoto.length;
  }

  List<String> get listTag {
    final List<String> _listTag =
        _box.get(_Database.listTag.name) ?? <String>[];
    return _listTag;
  }

  List<String> get listTagsWithItem {
    final List<String> _listTag = listTag;
    final List<PictureModel> _listPhoto = listPhoto;
    final List<String> _listTagWithItem = [];
    for (final String tag in _listTag) {
      for (final PictureModel pictureModel in _listPhoto) {
        if (pictureModel.tag == tag) {
          _listTagWithItem.add(tag);
          break;
        }
      }
    }
    return _listTagWithItem;
  }

  List<PictureModel> itemsFromTag(final String tag) {
    final List<PictureModel> _listPhoto = listPhoto;
    final List<PictureModel> _listPhotoWithTag = [];
    for (final PictureModel pictureModel in _listPhoto) {
      if (pictureModel.tag == tag) {
        _listPhotoWithTag.add(pictureModel);
      }
    }
    return _listPhotoWithTag;
  }

  void addPhoto({required PictureModel pictureModel}) {
    final List<PictureModel> _listPhoto = listPhoto;
    _listPhoto.add(pictureModel);
    _box.put(_Database.listPhoto.name, _listPhoto);
  }

  void addTag({required String tag}) {
    final List<String> _listTag = listTag;
    _listTag.add(tag);
    _box.put(_Database.listTag.name, _listTag);
  }

  void removePhoto({required String id}) {
    final List<PictureModel> _listPhoto = listPhoto;
    _listPhoto.remove(id);
    _box.put(_Database.listPhoto.name, _listPhoto);
  }

  void removeTag({required String tag}) {
    final List<String> _listTag = listTag;
    _listTag.remove(tag);
    _box.put(_Database.listTag.name, _listTag);
  }

  bool get boolFirstTime {
    final bool? _boolFirstTime = _box.get(_Database.boolFirstTime.name);
    return _boolFirstTime ?? true;
  }

  void setBoolFirstTime({required bool value}) {
    _box.put(_Database.boolFirstTime.name, value);
  }

  void clear() {
    _box.clear();
  }

  void clearAllTag() {
    _box.put(_Database.listTag.name, []);
  }

  void clearAllPhoto() {
    _box.put(_Database.listPhoto.name, []);
  }

  void delete() {
    _box.deleteFromDisk();
  }
}

final _PhotoGalleryDatabase photoGalleryDatabase =
    _PhotoGalleryDatabase.instance;
