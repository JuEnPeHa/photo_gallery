part of 'picture_model.dart';

// **************************************************************************
// typeAdapterGenerator
// **************************************************************************

class PictureModelAdapter extends TypeAdapter<PictureModel> {
  @override
  final int typeId = 1;

  @override
  PictureModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PictureModel.fromJson(Map<String, dynamic>.from(reader.read()));
      default:
        return PictureModel(
          id: reader.read(),
          title: reader.read(),
          description: reader.read(),
          base64: reader.read(),
          tag: reader.read(),
          date: reader.read(),
        );
    }
  }

  @override
  void write(BinaryWriter writer, PictureModel obj) {
    writer
      ..writeByte(1)
      ..write(obj.id)
      ..write(obj.title)
      ..write(obj.description)
      ..write(obj.base64)
      ..write(obj.tag)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PictureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
