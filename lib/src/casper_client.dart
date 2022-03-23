import 'dart:convert';

import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/http/casper_node_client.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_deploy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_state_root_hash.dart';

class CasperClient {
  final CasperNodeRpcClient _nodeClient;

  /// Creates an instance of Casper RPC client.
  ///
  /// [nodeUri] is the URI of the Casper node to connect to, including its RPC endpoint.
  /// For example, `Uri.parse("http://127.0.0.1:7777/rpc")`
  CasperClient(Uri nodeUri) : _nodeClient = CasperNodeRpcClient(nodeUri);

  /// Requests the list of peers connected to the node.
  Future<GetPeersResult> getPeers() async {
    return _nodeClient.getPeers();
  }

  /// Requests the state root hash of the node.
  /// If [blockHash] or [blockHeight] is not provided, root hash of the global state is returned.
  /// If [blockHash] is provided, the state root hash of the block with the given hash is returned.
  /// If [blockHeight] is provided, the state root hash of the block at the given height is returned.
  /// [blockHash] and [blockHeight] cannot be provided at the same time.
  Future<GetStateRootHashResult> getStateRootHash({String? blockHash, int? blockHeight}) async {
    if (blockHash != null) {
      return _nodeClient.getStateRootHash(GetStateRootHashParams.fromBlockHash(blockHash));
    } else if (blockHeight != null) {
      return _nodeClient.getStateRootHash(GetStateRootHashParams.fromBlockHeight(blockHeight));
    } else if (blockHash == null && blockHeight == null) {
      return _nodeClient.getStateRootHash();
    } else {
      // blockHash == null && blockHeight != null
      throw ArgumentError(
          "If a parameter is specified, either blockHash or blockHeight must be specified, but not both.");
    }
  }

  /// Requests the deploy object with given [deployHash] from the network.
  Future<GetDeployResult> getDeploy(String deployHash) async {
    return _nodeClient.getDeploy(GetDeployParams(deployHash));
  }
}
