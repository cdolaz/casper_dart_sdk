import 'package:casper_dart_sdk/src/constants.dart';
import 'package:casper_dart_sdk/src/http/http_server_proxy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_account_info.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_auction_info.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_balance.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_block_transfers.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_deploy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_dictionary_item.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_era_info_by_switch_block.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_item.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_state_root_hash.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_peers.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_status.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_block.dart';
import 'package:casper_dart_sdk/src/jsonrpc/put_deploy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/query_global_state.dart';

class CasperNodeRpcClient extends JsonRpcHttpServerProxy {
  CasperNodeRpcClient(url) : super(url, {'User-Agent': 'CasperDart/0.1'});

  Future<dynamic> getRpcSchema() async {
    return await call(RpcMethodName.rpcDiscover);
  }

  Future<GetPeersResult> getPeers() async {
    return GetPeersResult.fromJson(await call(RpcMethodName.infoGetPeers));
  }

  Future<GetStateRootHashResult> getStateRootHash([GetStateRootHashParams? params]) async {
    return GetStateRootHashResult.fromJson(await call(RpcMethodName.chainGetStateRootHash, params));
  }

  Future<GetDeployResult> getDeploy(GetDeployParams params) async {
    return GetDeployResult.fromJson(await call(RpcMethodName.infoGetDeploy, params.toJson()));
  }

  Future<GetStatusResult> getStatus() async {
    return GetStatusResult.fromJson(await call(RpcMethodName.infoGetStatus));
  }

  Future<GetBlockResult> getBlock(GetBlockParams params) async {
    return GetBlockResult.fromJson(await call(RpcMethodName.chainGetBlock, params.toJson()));
  }

  Future<GetBlockTransfersResult> getBlockTransfers(GetBlockTransfersParams params) async {
    return GetBlockTransfersResult.fromJson(await call(RpcMethodName.chainGetBlockTransfers, params.toJson()));
  }

  Future<GetBalanceResult> getBalance(GetBalanceParams params) async {
    return GetBalanceResult.fromJson(await call(RpcMethodName.stateGetBalance, params.toJson()));
  }

  Future<QueryGlobalStateResult> queryGlobalState(QueryGlobalStateParams params) async {
    return QueryGlobalStateResult.fromJson(await call(RpcMethodName.queryGlobalState, params.toJson()));
  }

  Future<GetItemResult> getItem(GetItemParams params) async {
    return GetItemResult.fromJson(await call(RpcMethodName.stateGetItem, params.toJson()));
  }

  Future<GetDictionaryItemResult> getDictionaryItem(GetDictionaryItemParams params) async {
    return GetDictionaryItemResult.fromJson(await call(RpcMethodName.stateGetDictionaryItem, params.toJson()));
  }

  Future<GetEraInfoBySwitchBlockResult> getEraInfoBySwitchBlock(GetEraInfoBySwitchBlockParams params) async {
    return GetEraInfoBySwitchBlockResult.fromJson(await call(RpcMethodName.chainGetEraInfoBySwitchBlock, params.toJson()));
  }

  Future<GetAuctionInfoResult> getAuctionInfo(GetAuctionInfoParams params) async {
    return GetAuctionInfoResult.fromJson(await call(RpcMethodName.stateGetAuctionInfo, params.toJson()));
  }

  Future<PutDeployResult> putDeploy(PutDeployParams params) async {
    return PutDeployResult.fromJson(await call(RpcMethodName.accountPutDeploy, params.toJson()));
  }

  /// [Deprecated]
  Future<PutDeployResult> putDeployJson(Map<String, dynamic> deployJson) async {
    return PutDeployResult.fromJson(await call(RpcMethodName.accountPutDeploy, deployJson));
  }

  Future<GetAccountInfoResult> getAccountInfo(GetAccountInfoParams params) async {
    return GetAccountInfoResult.fromJson(await call(RpcMethodName.stateGetAccountInfo, params.toJson()));
  }
}