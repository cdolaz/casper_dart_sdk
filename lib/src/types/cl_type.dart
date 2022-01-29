import 'package:json_annotation/json_annotation.dart';

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
  publicKey,
  any
}

class ClTypeJsonConverter implements JsonConverter<ClType, String> {
  const ClTypeJsonConverter();

  @override
  ClType fromJson(String json) {
    switch (json) {
      case 'Bool':
        return ClType.bool;
      case 'I32':
        return ClType.i32;
      case 'I64':
        return ClType.i64;
      case 'U8':
        return ClType.u8;
      case 'U32':
        return ClType.u32;
      case 'U64':
        return ClType.u64;
      case 'U128':
        return ClType.u128;
      case 'U256':
        return ClType.u256;
      case 'U512':
        return ClType.u512;
      case 'Unit':
        return ClType.unit;
      case 'String':
        return ClType.string;
      case 'Key':
        return ClType.key;
      case 'URef':
        return ClType.uref;
      case 'Option':
        return ClType.option;
      case 'List':
        return ClType.list;
      case 'ByteArray':
        return ClType.byteArray;
      case 'Result':
        return ClType.result;
      case 'Map':
        return ClType.map;
      case 'Tuple1':
        return ClType.tuple1;
      case 'Tuple2':
        return ClType.tuple2;
      case 'Tuple3':
        return ClType.tuple3;
      case 'PublicKey':
        return ClType.publicKey;
      case 'Any':
        return ClType.any;
      default:
        throw Exception('Unknown type: $json');
    }
  }

  @override
  String toJson(ClType value) {
    switch (value) {
      case ClType.bool:
        return 'Bool';
      case ClType.i32:
        return 'I32';
      case ClType.i64:
        return 'I64';
      case ClType.u8:
        return 'U8';
      case ClType.u32:
        return 'U32';
      case ClType.u64:
        return 'U64';
      case ClType.u128:
        return 'U128';
      case ClType.u256:
        return 'U256';
      case ClType.u512:
        return 'U512';
      case ClType.unit:
        return 'Unit';
      case ClType.string:
        return 'String';
      case ClType.key:
        return 'Key';
      case ClType.uref:
        return 'URef';
      case ClType.option:
        return 'Option';
      case ClType.list:
        return 'List';
      case ClType.byteArray:
        return 'ByteArray';
      case ClType.result:
        return 'Result';
      case ClType.map:
        return 'Map';
      case ClType.tuple1:
        return 'Tuple1';
      case ClType.tuple2:
        return 'Tuple2';
      case ClType.tuple3:
        return 'Tuple3';
      case ClType.publicKey:
        return 'PublicKey';
      case ClType.any:
        return 'Any';
      default:
        throw Exception('Unknown type: $value');
    }
  }
}
