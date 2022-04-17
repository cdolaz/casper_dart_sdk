import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';

part 'generated/get_auction_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetAuctionInfoParams {
  @JsonKey(name: 'block_identifier')
  BlockId? blockId;

  factory GetAuctionInfoParams.fromJson(Map<String, dynamic> json) =>
      _$GetAuctionInfoParamsFromJson(json);
  Map<String, dynamic> toJson() => _$GetAuctionInfoParamsToJson(this);

  GetAuctionInfoParams(this.blockId);  
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetAuctionInfoResult extends RpcResult {
  AuctionState? auctionState;

  factory GetAuctionInfoResult.fromJson(Map<String, dynamic> json) =>
      _$GetAuctionInfoResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAuctionInfoResultToJson(this);

  GetAuctionInfoResult(apiVersion, this.auctionState) : super(apiVersion);
}