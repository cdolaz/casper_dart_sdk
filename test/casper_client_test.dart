import 'dart:convert';

import 'package:casper_dart_sdk/src/http/http_server_proxy.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_deploy.dart';
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

  test('Can get deploy info', () async {
    final params = GetDeployParams("695caf631c960002bc579f356a299d6cb60dee229cbd743ab29f98eaf3ec3cbd");
    final result = await sdk.getDeploy(params);
    expect(result, isNotNull);
    expect(result.apiVersion, isNotEmpty);
    expect(result.deploy, isNotNull);
    expect(result.deploy.hash, "695caf631c960002bc579f356a299d6cb60dee229cbd743ab29f98eaf3ec3cbd");
    expect(result.deploy.session, isNotNull);
    expect(result.deploy.session.args[0].name, "amount");
  });
}
