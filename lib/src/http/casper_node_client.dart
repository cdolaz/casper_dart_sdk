import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/constants.dart';
import 'package:casper_dart_sdk/src/http/http_server_proxy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_balance.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_block_transfers.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_deploy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_state_root_hash.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_peers.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_status.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_block.dart';

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
}
