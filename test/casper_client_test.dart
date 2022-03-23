import 'dart:convert';
import 'dart:math';
import 'package:rpc_exceptions/rpc_exceptions.dart';
import 'package:casper_dart_sdk/src/http/http_server_proxy.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_deploy.dart';
import 'package:test/test.dart';
import 'dart:io' show Platform, exit;

void main() {
  group("Casper Dart SDK", () {
    // Read properties from the environment
    final String? serverUrl = Platform.environment['CASPER_TEST_NODE_RPC_URL'];

    test("can connect to test node", () {
      final explanation = "CASPER_TEST_NODE_RPC_URL environment variable is not set.\n"
          "Please set the environment variable CASPER_TEST_NODE_RPC_URL to the to "
          "the URL of the test-only Casper node that runs the RPC server.";
      expect(serverUrl, isNotNull, reason: explanation);
    });

    if (serverUrl == null) {
      return;
    }

    final sdk = CasperClient(Uri.parse(serverUrl));

    // TODO: Mocking client responses with ground truths could be better instead of relying on a test node.

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

    test("can get state root hash using a block id", () async {
      final result = await sdk.getStateRootHash(blockHash: "1ed477b9f19d06989e1dcfef57b5170a30f8f8b997be9d9376e501049473257a");
      expect(result, isNotNull);
      expect(result.stateRootHash.length, 64);
      expect(result.apiVersion, isNotEmpty);
    });

    test("can get state root hash using block height", () async {
      final result = await sdk.getStateRootHash(blockHeight: 10);
      expect(result, isNotNull);
      expect(result.stateRootHash.length, 64);
      expect(result.apiVersion, isNotEmpty);
    });

    test("can get deploy info", () async {
      final result = await sdk.getDeploy("0acff04af6a2b92d5aa515045175800a7e7bc5ae9a1267fee2ad9c66184bcc14");
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.deploy, isNotNull);
      expect(result.deploy.hash, "0acff04af6a2b92d5aa515045175800a7e7bc5ae9a1267fee2ad9c66184bcc14");
      expect(result.deploy.session, isNotNull);
      expect(result.deploy.session.args[0].name, "amount");
    });

    test("should throw an error when getting deploy info with an invalid hash", () async {
      expect(
        () async => await sdk.getDeploy("<invalid hash>"),
        throwsA(isA<RpcException>()),
      );
    });
  });
}
