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

  @PublicKeyNullableJsonConverter()
  PublicKey? validatorPublicKey;

  VestingSchedule? vestingSchedule;

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);
  Map<String, dynamic> toJson() => _$BidToJson(this);

  Bid(this.bondingPurse, this.delegationRate, this.delegators, this.inactive, this.stakedAmount,
      this.validatorPublicKey, this.vestingSchedule);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ValidatorBid {
  @PublicKeyJsonConverter()
  PublicKey publicKey;
  Bid bid;

  factory ValidatorBid.fromJson(Map<String, dynamic> json) => _$ValidatorBidFromJson(json);
  Map<String, dynamic> toJson() => _$ValidatorBidToJson(this);

  ValidatorBid(this.publicKey, this.bid);
}
