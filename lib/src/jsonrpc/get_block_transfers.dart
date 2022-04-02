import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/jsonrpc/rpc_result.dart';
import 'package:casper_dart_sdk/src/jsonrpc/rpc_params.dart';
import 'package:casper_dart_sdk/src/types/block.dart';
import 'package:casper_dart_sdk/src/types/transfer.dart';

part 'generated/get_block_transfers.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetBlockTransfersParams extends RpcParams {
  @JsonKey(name: 'block_identifier')
  BlockId blockId;

  factory GetBlockTransfersParams.fromJson(Map<String, dynamic> json) => _$GetBlockTransfersParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetBlockTransfersParamsToJson(this);

  GetBlockTransfersParams(this.blockId) : super();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GetBlockTransfersResult extends RpcResult {
  String blockHash;

  List<Transfer> transfers;

  factory GetBlockTransfersResult.fromJson(Map<String, dynamic> json) => _$GetBlockTransfersResultFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetBlockTransfersResultToJson(this);

  GetBlockTransfersResult(apiVersion, this.blockHash, this.transfers) : super(apiVersion);
}