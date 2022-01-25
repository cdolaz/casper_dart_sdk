import 'package:casper_dart_sdk/src/constants.dart';
import 'package:casper_dart_sdk/src/http/http_server_proxy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_deploy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_state_root_hash.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_peers.dart';

class CasperNodeRpcClient extends JsonRpcHttpServerProxy {
  CasperNodeRpcClient(url) : super(url, {'User-Agent': 'CasperDart/0.1'});

  Future<GetPeersResult> getPeers() async {
    return GetPeersResult.fromJson(await call(RpcMethodName.infoGetPeers));
  }

  Future<GetStateRootHashResult> getStateRootHash() async {
    return GetStateRootHashResult.fromJson(
        await call(RpcMethodName.chainGetStateRootHash));
  }

  Future<GetDeployResult> getDeploy(GetDeployParams params) async {
    return GetDeployResult.fromJson(
        await call(RpcMethodName.infoGetDeploy, params.toJson()));
  }
}
