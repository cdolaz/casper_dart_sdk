import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/helpers/json_utils.dart';

import 'package:casper_dart_sdk/src/types/cl_public_key.dart';

class ValidatorWeight {
  ClPublicKey publicKey;

  BigInt? weight;

  ValidatorWeight(this.publicKey, this.weight);
}

class ValidatorWeightJsonConverter implements JsonConverter<ValidatorWeight, Map<String, dynamic>> {
  const ValidatorWeightJsonConverter();

  @override
  ValidatorWeight fromJson(Map<String, dynamic> json) {
    late ClPublicKey publicKey;
    if (json.containsKey("validator")) {
      publicKey = ClPublicKeyJsonConverter().fromJson(json["validator"]);
    } else if (json.containsKey("public_key")) {
      publicKey = ClPublicKeyJsonConverter().fromJson(json["public_key"]);
    }
    return ValidatorWeight(
      publicKey,
      json['weight'] == null ? null : BigInt.parse(json['weight']),
    );
  }

  @override
  Map<String, dynamic> toJson(ValidatorWeight object) {
    return {
      'public_key': ClPublicKeyJsonConverter().toJson(object.publicKey), // TODO: This field can also be 'validator'
      'weight': object.weight?.toString(),
    };
  }

  factory ValidatorWeightJsonConverter.create() => ValidatorWeightJsonConverter();
}

class ValidatorWeightJsonListConverter extends JsonListConverter<ValidatorWeight> {
  const ValidatorWeightJsonListConverter() : super(ValidatorWeightJsonConverter.create);
}