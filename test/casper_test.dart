import 'package:casper_dart_sdk/casper.dart';
import 'package:test/test.dart';
import 'dart:io' show Platform; 

void main() {
  // Read properties from the environment
  final String serverUrl = Platform.environment['CASPER_NODE_RPC_URL'] ?? 'http://localhost:7777/rpc';
  final sdk = CasperSdk(Uri.parse(serverUrl));
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
  });
}
