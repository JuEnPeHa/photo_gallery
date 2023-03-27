part of 'picture_model.dart';

// **************************************************************************
// typeAdapterGenerator
// **************************************************************************

class PictureModelAdapter extends TypeAdapter<PictureModel> {
  @override
  final int typeId = 1;

  @override
  PictureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PictureModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      base64: fields[3] as String,
      tag: fields[4] as String,
      date: fields[5] as DateTime,
    );

    // switch (reader.readByte()) {
    //   case 0:
    //     return PictureModel.fromJson(Map<String, dynamic>.from(reader.read()));
    //   default:
    //     return PictureModel(
    //       id: reader.read(),
    //       title: reader.read(),
    //       description: reader.read(),
    //       base64: reader.read(),
    //       tag: reader.read(),
    //       date: reader.read(),
    //     );
    // }
  }

  @override
  void write(BinaryWriter writer, PictureModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.base64)
      ..writeByte(4)
      ..write(obj.tag)
      ..writeByte(5)
      ..write(obj.date);

    // switch (obj.runtimeType) {
    //   case PictureModel:
    //     writer
    //       ..writeByte(1)
    //       ..writeByte(0)
    //       ..write(obj.toJson());
    //     break;
    //   default:
    //     writer
    //       ..writeByte(6)
    //       ..writeByte(0)
    //       ..write(obj.id)
    //       ..writeByte(1)
    //       ..write(obj.title)
    //       ..writeByte(2)
    //       ..write(obj.description)
    //       ..writeByte(3)
    //       ..write(obj.base64)
    //       ..writeByte(4)
    //       ..write(obj.tag)
    //       ..writeByte(5)
    //       ..write(obj.date);
    // }
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
