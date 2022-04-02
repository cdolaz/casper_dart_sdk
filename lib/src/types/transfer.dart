import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'generated/transfer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Transfer {
  late BigInt amount;

  late String deployHash;

  // TODO: Convert to concrete type, AccountHash
  late String from;

  late BigInt gas;

  late int? id;

  // TODO: Convert to concrete type, URef
  late String source;

  // TODO: Convert to concrete type, URef
  late String target;

  // TODO: Convert to concrete type, AccountHash
  late String? to;

  factory Transfer.fromJson(Map<String, dynamic> json) => _$TransferFromJson(json);
  Map<String, dynamic> toJson() => _$TransferToJson(this);

  Transfer();
}
