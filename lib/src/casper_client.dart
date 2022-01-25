import 'dart:convert';

import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/http/casper_node_client.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_deploy.dart';

class CasperClient {
  final CasperNodeRpcClient _nodeClient;

  CasperClient(Uri nodeUri) : _nodeClient = CasperNodeRpcClient(nodeUri);

  Future<GetPeersResult> getPeers() async {
    return _nodeClient.getPeers();
  }

  Future<GetStateRootHashResult> getStateRootHash() async {
    return _nodeClient.getStateRootHash();
  }

  Future<GetDeployResult> getDeploy(GetDeployParams params) async {
    return _nodeClient.getDeploy(params);
  }
}
