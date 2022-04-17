import 'package:json_annotation/json_annotation.dart';
import 'package:casper_dart_sdk/src/types/executable_deploy_item.dart';
import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:casper_dart_sdk/src/types/named_key.dart';

part 'generated/account.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Account {
  @AccountHashKeyJsonConverter()
  AccountHashKey accountHash;

  ActionThresholds actionThresholds;

  List<AssociatedKey> associatedKeys;

  @UrefJsonConverter()
  Uref mainPurse;

  List<NamedKey> namedKeys;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  Account(this.accountHash, this.actionThresholds, this.associatedKeys, this.mainPurse, this.namedKeys);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ActionThresholds {
  int deployment;
  int keyManagement;

  factory ActionThresholds.fromJson(Map<String, dynamic> json) => _$ActionThresholdsFromJson(json);
  Map<String, dynamic> toJson() => _$ActionThresholdsToJson(this);

  ActionThresholds(this.deployment, this.keyManagement);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AssociatedKey {
  @AccountHashKeyJsonConverter()
  AccountHashKey accountHash;

  int weight;

  factory AssociatedKey.fromJson(Map<String, dynamic> json) => _$AssociatedKeyFromJson(json);
  Map<String, dynamic> toJson() => _$AssociatedKeyToJson(this);

  AssociatedKey(this.accountHash, this.weight);
}
