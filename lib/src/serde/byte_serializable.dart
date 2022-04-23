import 'dart:typed_data';

abstract class ByteSerializable {
  Uint8List toBytes();
}