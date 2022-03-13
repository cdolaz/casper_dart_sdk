import 'dart:convert';
import 'dart:math';

import 'package:casper_dart_sdk/src/http/http_server_proxy.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_deploy.dart';
import 'package:test/test.dart';
import 'dart:io' show Platform, exit;

void main() {
  group("Casper Dart SDK", () {
    // Read properties from the environment
    final String? serverUrl = Platform.environment['CASPER_NODE_RPC_URL'];

    test("can connect to test node", () {
      final explanation = "CASPER_NODE_RPC_URL environment variable is not set.\n"
          "Please set the environment variable CASPER_NODE_RPC_URL to the to "
          "the URL of the Casper node that runs the RPC server you want to test against.";
      expect(serverUrl, isNotNull, reason: explanation);
    });

    if (serverUrl == null) {
      return;
    }

    final sdk = CasperClient(Uri.parse(serverUrl));
    final rpcClient = JsonRpcHttpServerProxy(Uri.parse(serverUrl));

    test("can get node peers", () async {
      final result = await sdk.getPeers();
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.peers, isNotNull);
      if (result.peers.isNotEmpty) {
        expect(result.peers.first.address, isNotEmpty);
        expect(result.peers.first.nodeId, isNotEmpty);
      }
    });

    test("can get state root hash", () async {
      final result = await sdk.getStateRootHash();
      expect(result, isNotNull);
      expect(result.stateRootHash.length, 64);
      expect(result.apiVersion, isNotEmpty);
    });

    test("can get deploy info", () async {
      final params = GetDeployParams("0acff04af6a2b92d5aa515045175800a7e7bc5ae9a1267fee2ad9c66184bcc14");
      final result = await sdk.getDeploy(params);
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.deploy, isNotNull);
      expect(result.deploy.hash, "0acff04af6a2b92d5aa515045175800a7e7bc5ae9a1267fee2ad9c66184bcc14");
      expect(result.deploy.session, isNotNull);
      expect(result.deploy.session.args[0].name, "amount");
    });
  });
}
