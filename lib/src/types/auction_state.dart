import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/types/bid.dart';
import 'package:casper_dart_sdk/src/types/era.dart';

part 'generated/auction_state.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuctionState {
  List<ValidatorBid> bids;
  
  int blockHeight;
  
  List<EraValidators> eraValidators;
  
  String stateRootHash;

  factory AuctionState.fromJson(Map<String, dynamic> json) => _$AuctionStateFromJson(json);
  Map<String, dynamic> toJson() => _$AuctionStateToJson(this);

  AuctionState(this.bids, this.blockHeight, this.eraValidators, this.stateRootHash);
}
