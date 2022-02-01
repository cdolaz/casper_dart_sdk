import 'dart:convert';

import 'package:casper_dart_sdk/src/http/http_server_proxy.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:test/test.dart';
import 'dart:io' show Platform;

void main() {
  // Read properties from the environment
  final String serverUrl = Platform.environment['CASPER_NODE_RPC_URL'] ?? 'http://185.246.84.43:7777/rpc';
  final sdk = CasperClient(Uri.parse(serverUrl));
  final rpcClient = JsonRpcHttpServerProxy(Uri.parse(serverUrl));

  test('Can get node peers', () async {
    final peers = await sdk.getPeers();
    expect(peers, isNotNull);
    expect(peers.apiVersion, isNotEmpty);
    expect(peers.peers, isNotEmpty);
  });

  test('Can get state root hash', () async {
    final rootHash = await sdk.getStateRootHash();
    expect(rootHash, isNotNull);
    expect(rootHash.stateRootHash.length, 64);
    expect(rootHash.apiVersion, isNotEmpty);
  });

  // test('Can get deploy info', () async {
  //   // final deployInfo = await sdk.getDeploy("695caf631c960002bc579f356a299d6cb60dee229cbd743ab29f98eaf3ec3cbd");
  //   // print();
  //   final String deployInfoResStr = await rpcClient.callRaw("info_get_deploy", {"deploy_hash":"695caf631c960002bc579f356a299d6cb60dee229cbd743ab29f98eaf3ec3cbd"});
  //   // Print with indent
  //   final deployInfoRes = json.decode(deployInfoResStr);
  //   print(JsonEncoder.withIndent("    ").convert(deployInfoRes));
  //   // expect(deployInfo, isNotNull);
  // });
}
