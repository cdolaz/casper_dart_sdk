import 'dart:io' show Platform;

import 'package:test/test.dart';

import 'package:rpc_exceptions/rpc_exceptions.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';

void main() {
  group("Casper Dart SDK", () {
    // Read properties from the environment
    final String? serverUrl = Platform.environment['CASPER_TEST_NODE_RPC_URL'];

    test("can connect to test node", () {
      final explanation = "CASPER_TEST_NODE_RPC_URL environment variable is not set.\n"
          "Please set the environment variable CASPER_TEST_NODE_RPC_URL to the to "
          "the URL of the test-only Casper node that runs the RPC server.";
      expect(serverUrl, isNotNull, reason: explanation);
      expect(serverUrl, isNotEmpty, reason: explanation);
    });

    if (serverUrl == null) {
      return;
    }

    final node = CasperClient(Uri.parse(serverUrl));

    // TODO: Mocking client responses with ground truths could be better instead of relying on a test node.

    test("can get RPC schema", () async {
      final schema = await node.getRpcSchema();
      expect(schema, isNotNull);
    });

    test("can get node peers", () async {
      final result = await node.getPeers();
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.peers, isNotNull);
      if (result.peers.isNotEmpty) {
        expect(result.peers.first.address, isNotEmpty);
        expect(result.peers.first.nodeId, isNotEmpty);
      }
    });

    test("can get state root hash", () async {
      final result = await node.getStateRootHash();
      expect(result, isNotNull);
      expect(result.stateRootHash.length, 64);
      expect(result.apiVersion, isNotEmpty);
    });

    test("can get state root hash using a block id", () async {
      final result = await node
          .getStateRootHash(BlockId.fromHash("1ed477b9f19d06989e1dcfef57b5170a30f8f8b997be9d9376e501049473257a"));
      expect(result, isNotNull);
      expect(result.stateRootHash.length, 64);
      expect(result.apiVersion, isNotEmpty);
    });

    test("can get state root hash using block height", () async {
      final result = await node.getStateRootHash(BlockId.fromHeight(10));
      expect(result, isNotNull);
      expect(result.stateRootHash.length, 64);
      expect(result.apiVersion, isNotEmpty);
    });

    test("can get deploy info", () async {
      final result = await node.getDeploy("0acff04af6a2b92d5aa515045175800a7e7bc5ae9a1267fee2ad9c66184bcc14");
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.deploy, isNotNull);
      expect(result.deploy.hash, "0acff04af6a2b92d5aa515045175800a7e7bc5ae9a1267fee2ad9c66184bcc14");
      expect(result.deploy.session, isNotNull);
      expect(result.deploy.session.args[0].name, "amount");
    });

    test("should throw an error when getting deploy info with an invalid hash", () async {
      expect(
        () async => await node.getDeploy("<invalid hash>"),
        throwsA(isA<RpcException>()),
      );
    });

    test("can get node's status info", () async {
      final result = await node.getStatus();
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.chainspecName, "casper-test");
      expect(result.startingStateRootHash, isNotEmpty);
    });

    test("can get the block info by its height", () async {
      final result = await node.getBlock(BlockId.fromHeight(10));
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.block, isNotNull);
      expect(result.block!.header.height, 10);
    });

    test("can get block info by its hash", () async {
      final result = await node.getBlock(BlockId.fromHash("63fba0849c1301c2ecad7772432060cdb4ab6cad3e3a5ebec2d3eeee5ea986fb"));
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.block, isNotNull);
      expect(result.block!.hash, "63fba0849c1301c2ecad7772432060cdb4ab6cad3e3a5ebec2d3eeee5ea986fb");
    });

    test("can get block transfers by block hash", () async {
      final result = await node.getBlockTransfers(BlockId.fromHash("a1f829cff2389cf6637ed89fb2fab48351b1278c131ee8445e1e28333c9a44d0"));
      expect(result.transfers, isNotEmpty);
    });

    test("can get balance", () async {
      Uref purse = Uref("uref-54fd72455872082a254b0160e94a86245acd0c441f526688bda1261d0969057a-007");
      final result = await node.getBalance(purse);
      expect(result, isNotNull);
    });

    test("can query a global state", () async {
      final result = await node.queryGlobalState("transfer-9f5fe878c29fc3bf537c0509ec5abe1781a72bb6a3197a440e3e68247fba5909",
         "39f2800688b94f68ca640b26c7d0f50a90d2ce9af55c9484e66151b544345303", false);
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.storedValue, isA<Transfer>());
    });

    test("can get era info by switch block", () async {
      final blockHash = "d2077716e5b8796723c5720237239720f54e6ada54e3357f2c4896f2a51a6d8f";
      final result = await node.getEraInfoBySwitchBlock(BlockId.fromHash(blockHash));
      expect(result, isNotNull);
      expect(result.apiVersion, isNotEmpty);
      expect(result.eraSummary, isNotNull);
      expect(result.eraSummary!.blockHash, blockHash);
    });
  });
}
