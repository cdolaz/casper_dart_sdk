import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:casper_dart_sdk/src/serde/byte_serializable.dart';
import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';

enum ClType {
  bool,
  i32,
  i64,
  u8,
  u32,
  u64,
  u128,
  u256,
  u512,
  unit,
  string,
  key,
  uref,
  option,
  list,
  byteArray,
  result,
  map,
  tuple1,
  tuple2,
  tuple3,
  any,
  publicKey
}

class ClTypeDescriptor extends Equatable implements ByteSerializable {
  final ClType type;
  ClTypeDescriptor(this.type);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.writeUint8(type.index);
    return mem.toBytes();
  }

  @override
  List<Object?> get props => [type];
}

class ClOptionTypeDescriptor extends ClTypeDescriptor {
  final ClTypeDescriptor optionType;
  ClOptionTypeDescriptor(this.optionType) : super(ClType.option);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(super.toBytes());
    mem.write(optionType.toBytes());
    return mem.toBytes();
  }

  @override
  List<Object?> get props => [optionType, ...super.props];
}

class ClListTypeDescriptor extends ClTypeDescriptor {
  final ClTypeDescriptor listType;
  ClListTypeDescriptor(this.listType) : super(ClType.list);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(super.toBytes());
    mem.write(listType.toBytes());
    return mem.toBytes();
  }

  @override
  List<Object?> get props => [listType, ...super.props];
}

class ClByteArrayTypeDescriptor extends ClTypeDescriptor {
  final int length;
  ClByteArrayTypeDescriptor(this.length) : super(ClType.byteArray);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(super.toBytes());
    mem.writeInt32(length);
    return mem.toBytes();
  }

  @override
  List<Object?> get props => [length, ...super.props];
}

class ClResultTypeDescriptor extends ClTypeDescriptor {
  final ClTypeDescriptor okType;
  final ClTypeDescriptor errType;
  ClResultTypeDescriptor(this.okType, this.errType) : super(ClType.result);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(super.toBytes());
    mem.write(okType.toBytes());
    mem.write(errType.toBytes());
    return mem.toBytes();
  }

  @override
  List<Object?> get props => [okType, errType, ...super.props];
}

class ClMapTypeDescriptor extends ClTypeDescriptor {
  final ClTypeDescriptor keyType;
  final ClTypeDescriptor valueType;
  ClMapTypeDescriptor(this.keyType, this.valueType) : super(ClType.map);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(super.toBytes());
    mem.write(keyType.toBytes());
    mem.write(valueType.toBytes());
    return mem.toBytes();
  }

  @override
  List<Object?> get props => [keyType, valueType, ...super.props];
}

class ClTuple1TypeDescriptor extends ClTypeDescriptor {
  final ClTypeDescriptor firstType;
  ClTuple1TypeDescriptor(this.firstType) : super(ClType.tuple1);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(super.toBytes());
    mem.write(firstType.toBytes());
    return mem.toBytes();
  }

  @override
  List<Object?> get props => [firstType, ...super.props];
}

class ClTuple2TypeDescriptor extends ClTypeDescriptor {
  final ClTypeDescriptor firstType;
  final ClTypeDescriptor secondType;
  ClTuple2TypeDescriptor(this.firstType, this.secondType) : super(ClType.tuple2);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(super.toBytes());
    mem.write(firstType.toBytes());
    mem.write(secondType.toBytes());
    return mem.toBytes();
  }

  @override
  List<Object?> get props => [firstType, secondType, ...super.props];
}

class ClTuple3TypeDescriptor extends ClTypeDescriptor {
  final ClTypeDescriptor firstType;
  final ClTypeDescriptor secondType;
  final ClTypeDescriptor thirdType;
  ClTuple3TypeDescriptor(this.firstType, this.secondType, this.thirdType) : super(ClType.tuple3);

  @override
  Uint8List toBytes() {
    ByteDataWriter mem = ByteDataWriter(endian: Endian.little);
    mem.write(super.toBytes());
    mem.write(firstType.toBytes());
    mem.write(secondType.toBytes());
    mem.write(thirdType.toBytes());
    return mem.toBytes();
  }

  @override
  List<Object?> get props => [firstType, secondType, thirdType, ...super.props];
}

class ClTypeDescriptorJsonConverter implements JsonConverter<ClTypeDescriptor, dynamic> {
  const ClTypeDescriptorJsonConverter();

  @override
  ClTypeDescriptor fromJson(dynamic json) {
    // If json is string, convert it to ClType
    if (json is String) {
      return ClTypeDescriptor(
          ClType.values.firstWhere((type) => type.toString().toLowerCase() == "cltype." + json.toLowerCase()));
    } else if (json is Map<String, dynamic>) {
      if (json.containsKey('Option')) {
        return ClOptionTypeDescriptor(fromJson(json['Option']));
      } else if (json.containsKey('List')) {
        return ClListTypeDescriptor(fromJson(json['List']));
      } else if (json.containsKey('ByteArray')) {
        return ClByteArrayTypeDescriptor(json['ByteArray']);
      } else if (json.containsKey('Result')) {
        final result = json['Result'];
        return ClResultTypeDescriptor(fromJson(result['ok']), fromJson(result['err']));
      } else if (json.containsKey('Map')) {
        final map = json['Map'];
        return ClMapTypeDescriptor(fromJson(map['key']), fromJson(map['value']));
      } else if (json.containsKey('Tuple1')) {
        return ClTuple1TypeDescriptor(fromJson(json['Tuple1'][0]));
      } else if (json.containsKey('Tuple2')) {
        final tuple2 = json['Tuple2'];
        return ClTuple2TypeDescriptor(fromJson(tuple2[0]), fromJson(tuple2[1]));
      } else if (json.containsKey('Tuple3')) {
        final tuple3 = json['Tuple3'];
        return ClTuple3TypeDescriptor(fromJson(tuple3[0]), fromJson(tuple3[1]), fromJson(tuple3[2]));
      } else {
        throw Exception('Unknown type $json');
      }
    } else {
      throw Exception('Invalid json type $json');
    }
  }

  @override
  dynamic toJson(ClTypeDescriptor value) {
    if (value is ClOptionTypeDescriptor) {
      return {'Option': toJson(value.optionType)};
    } else if (value is ClListTypeDescriptor) {
      return {'List': toJson(value.listType)};
    } else if (value is ClByteArrayTypeDescriptor) {
      return {'ByteArray': value.length};
    } else if (value is ClResultTypeDescriptor) {
      return {
        'Result': {'ok': toJson(value.okType), 'err': toJson(value.errType)}
      };
    } else if (value is ClMapTypeDescriptor) {
      return {
        'Map': {'key': toJson(value.keyType), 'value': toJson(value.valueType)}
      };
    } else if (value is ClTuple1TypeDescriptor) {
      return {
        'Tuple1': [toJson(value.firstType)]
      };
    } else if (value is ClTuple2TypeDescriptor) {
      return {
        'Tuple2': [toJson(value.firstType), toJson(value.secondType)]
      };
    } else if (value is ClTuple3TypeDescriptor) {
      return {
        'Tuple3': [toJson(value.firstType), toJson(value.secondType), toJson(value.thirdType)]
      };
    } else {
      return capitalizeFirstLetter(value.type.toString().split('.').last);
    }
  }
}
