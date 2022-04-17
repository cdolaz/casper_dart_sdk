import 'package:casper_dart_sdk/src/helpers/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/types/public_key.dart';
import 'package:casper_dart_sdk/src/types/vesting_schedule.dart';
import 'package:casper_dart_sdk/src/types/global_state_key.dart';

class Delegator {
  Uref bondingPurse;

  PublicKey? delegatee;

  PublicKey publicKey;

  BigInt stakedAmount;

  VestingSchedule? vestingSchedule;

  Delegator(this.bondingPurse, this.delegatee, this.publicKey, this.stakedAmount, this.vestingSchedule);
}

class DelegatorJsonConverter extends JsonConverter<Delegator, Map<String, dynamic>> {
  const DelegatorJsonConverter();

  @override
  Delegator fromJson(Map<String, dynamic> json) {
    late Uref bondingPurse;
    if (json.containsKey("bonding_purse")) {
      bondingPurse = UrefJsonConverter().fromJson(json["bonding_purse"]);
    }
    PublicKey? delegatee;
    if (json.containsKey("validator_public_key")) {
      delegatee = PublicKeyJsonConverter().fromJson(json["validator_public_key"]);
    }
    late PublicKey publicKey;
    if (json.containsKey("public_key")) {
      publicKey = PublicKeyJsonConverter().fromJson(json["public_key"]);
    } else if (json.containsKey("delegator_public_key")) {
      publicKey = PublicKeyJsonConverter().fromJson(json["delegator_public_key"]);
    }
    late BigInt stakedAmount;
    if (json.containsKey("staked_amount")) {
      stakedAmount = BigInt.parse(json["staked_amount"]);
    }
    VestingSchedule? vestingSchedule;
    if (json.containsKey("vesting_schedule")) {
      vestingSchedule = VestingSchedule.fromJson(json["vesting_schedule"]);
    }
    return Delegator(bondingPurse, delegatee, publicKey, stakedAmount, vestingSchedule);
  }

  @override
  Map<String, dynamic> toJson(Delegator object) {
    final Map<String, dynamic> json = {
      "bonding_purse": UrefJsonConverter().toJson(object.bondingPurse),
      "delegator_public_key": PublicKeyJsonConverter().toJson(object.publicKey),
      "staked_amount": object.stakedAmount.toString(),
    };
    if (object.delegatee != null) {
      json["validator_public_key"] = PublicKeyJsonConverter().toJson(object.delegatee!);
    }
    if (object.vestingSchedule != null) {
      json["vesting_schedule"] = object.vestingSchedule!.toJson();
    }
    return json;
  }

  factory DelegatorJsonConverter.create() => DelegatorJsonConverter();
}

class DelegatorJsonListConverter extends JsonListConverter<Delegator> {
  const DelegatorJsonListConverter() : super(DelegatorJsonConverter.create);
}