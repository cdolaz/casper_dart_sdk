import 'package:casper_dart_sdk/casper.dart';
import 'package:casper_dart_sdk/src/http/casper_node_client.dart';
import 'package:casper_dart_sdk/src/jsonrpc/results/get_state_root_hash.dart';

class CasperSdk {
  final CasperNodeRpcClient _nodeClient;

  CasperSdk(Uri nodeUri) : _nodeClient = CasperNodeRpcClient(nodeUri);

  Future<GetPeersResult> getPeers() async {
    return _nodeClient.getPeers();
  }

  Future<GetStateRootHashResult> getStateRootHash() async {
    return _nodeClient.getStateRootHash();
  }
}
