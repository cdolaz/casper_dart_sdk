import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:casper_dart_sdk/src/types/vesting_schedule.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';
import 'package:casper_dart_sdk/src/types/delegator.dart';

part 'generated/bid.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Bid {
  @UrefJsonConverter()
  Uref bondingPurse;
  
  int delegationRate;

  @DelegatorJsonListConverter()
  List<Delegator> delegators;

  bool inactive;

  BigInt stakedAmount;

  @PublicKeyJsonConverter()
  @JsonKey(name: 'validator_public_key')
  PublicKey publicKey;

  VestingSchedule vestingSchedule;

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);
  Map<String, dynamic> toJson() => _$BidToJson(this);

  Bid(this.bondingPurse, this.delegationRate, this.delegators, this.inactive, this.stakedAmount, this.publicKey, this.vestingSchedule);
}