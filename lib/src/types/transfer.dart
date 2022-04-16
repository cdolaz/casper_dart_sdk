import 'dart:core';

import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/transfer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Transfer {
  late BigInt amount;

  late String deployHash;

  @AccountHashKeyJsonConverter()
  late AccountHashKey from;

  late BigInt gas;

  late int? id;

  @UrefJsonConverter()
  late Uref source;

  @UrefJsonConverter()
  late Uref target;

  @AccountHashKeyJsonConverter()
  late String? to;

  factory Transfer.fromJson(Map<String, dynamic> json) => _$TransferFromJson(json);
  Map<String, dynamic> toJson() => _$TransferToJson(this);

  Transfer();
}
