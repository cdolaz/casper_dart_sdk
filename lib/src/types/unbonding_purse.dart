import 'package:casper_dart_sdk/src/types/cl_public_key.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/types/global_state_key.dart';

part 'generated/unbonding_purse.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UnbondingPurse {
  BigInt amount;

  @UrefJsonConverter()
  Uref bondingPurse;

  int eraOfCreation;

  @ClPublicKeyJsonConverter()
  ClPublicKey unbonderPublicKey;

  @ClPublicKeyJsonConverter()
  ClPublicKey validatorPublicKey;

  factory UnbondingPurse.fromJson(Map<String, dynamic> json) =>
      _$UnbondingPurseFromJson(json);
  Map<String, dynamic> toJson() => _$UnbondingPurseToJson(this);

  UnbondingPurse(this.amount, this.bondingPurse, this.eraOfCreation,
      this.unbonderPublicKey, this.validatorPublicKey);
}