
import 'package:casper_dart_sdk/src/helpers/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/types/public_key.dart';

part 'generated/era.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EraInfo {
  @SeigniorageAllocationJsonListConverter()
  List<SeigniorageAllocation> seigniorageAllocations;

  factory EraInfo.fromJson(Map<String, dynamic> json) => _$EraInfoFromJson(json);
  Map<String, dynamic> toJson() => _$EraInfoToJson(this);

  EraInfo(this.seigniorageAllocations);
}

class SeigniorageAllocation {
  bool isDelegator;
  
  PublicKey? delegatorPublicKey;

  PublicKey? validatorPublicKey;
  
  BigInt amount;

  SeigniorageAllocation(this.isDelegator, this.delegatorPublicKey, this.validatorPublicKey, this.amount);
}

class SeigniorageAllocationJsonConverter extends JsonConverter<SeigniorageAllocation, Map<String, dynamic>> {
  const SeigniorageAllocationJsonConverter();

  @override
  SeigniorageAllocation fromJson(Map<String, dynamic> json) {
    final String top = json.keys.first;
    Map<String, dynamic> inner = json[top];
    final bool isDelegator = (top.toLowerCase() == "delegator");
    if (isDelegator) {
      inner = inner["Delegator"];
    } else {
      inner = inner["Validator"];
    }
    PublicKey? delegatorPublicKey;
    PublicKey? validatorPublicKey;
    if (inner.containsKey("delegator_public_key")) {
      delegatorPublicKey = PublicKeyJsonConverter().fromJson(inner["delegator_public_key"]);
    } 
    if (inner.containsKey("validator_public_key")) {
      validatorPublicKey = PublicKeyJsonConverter().fromJson(inner["validator_public_key"]);
    }
    final BigInt amount = BigInt.parse(inner["amount"]);
    return SeigniorageAllocation(isDelegator, delegatorPublicKey, validatorPublicKey, amount);
  }

  @override
  Map<String, dynamic> toJson(SeigniorageAllocation object) {
    Map<String, dynamic> json = {};
    String key = object.isDelegator ? "Delegator" : "Validator";
    json[key] = {};
    if (object.delegatorPublicKey != null) {
      json[key]["delegator_public_key"] = PublicKeyJsonConverter().toJson(object.delegatorPublicKey!);
    }
    if (object.validatorPublicKey != null) {
      json[key]["validator_public_key"] = PublicKeyJsonConverter().toJson(object.validatorPublicKey!);
    }
    json[key]["amount"] = object.amount.toString();
    return json;
  }

  factory SeigniorageAllocationJsonConverter.create() => SeigniorageAllocationJsonConverter();
}

class SeigniorageAllocationJsonListConverter extends JsonListConverter<SeigniorageAllocation> {
  const SeigniorageAllocationJsonListConverter() : super(SeigniorageAllocationJsonConverter.create);
}