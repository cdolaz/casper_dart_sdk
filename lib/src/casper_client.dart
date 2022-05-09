import 'dart:convert';

import 'package:casper_dart_sdk/src/http/casper_node_client.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_auction_info.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_balance.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_block_transfers.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_deploy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_era_info_by_switch_block.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_item.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_state_root_hash.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_status.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_block.dart';
import 'package:casper_dart_sdk/src/jsonrpc/put_deploy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/query_global_state.dart';
import 'package:casper_dart_sdk/src/jsonrpc/get_peers.dart';

import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:casper_dart_sdk/src/types/block.dart';
import 'package:casper_dart_sdk/src/types/deploy.dart';

class CasperClient {
  final CasperNodeRpcClient _nodeClient;

  /// Creates an instance of Casper RPC client.
  ///
  /// [nodeUri] is the URI of the Casper node to connect to, including its RPC endpoint.
  /// For example, `Uri.parse("http://127.0.0.1:7777/rpc")`
  CasperClient(Uri nodeUri) : _nodeClient = CasperNodeRpcClient(nodeUri);

  Future<dynamic> getRpcSchema() async {
    return _nodeClient.getRpcSchema();
  }

  /// Requests the list of peers connected to the node.
  Future<GetPeersResult> getPeers() async {
    return _nodeClient.getPeers();
  }

  /// Requests the state root hash of the node.
  /// If specified, requests the state root hash of the block identified by [blockId].
  Future<GetStateRootHashResult> getStateRootHash([BlockId? blockId]) async {
    if (blockId == null) {
      return _nodeClient.getStateRootHash();
    } else {
      return _nodeClient.getStateRootHash(GetStateRootHashParams(blockId));
    }
  }

  /// Requests the deploy object with given [deployHash] from the network.
  Future<GetDeployResult> getDeploy(String deployHash) async {
    return _nodeClient.getDeploy(GetDeployParams(deployHash));
  }

  /// Requests the current status of the node.
  Future<GetStatusResult> getStatus() async {
    return _nodeClient.getStatus();
  }

  /// Requests the block identified by [blockId] from the network.
  Future<GetBlockResult> getBlock(BlockId blockId) async {
    return _nodeClient.getBlock(GetBlockParams(blockId));
  }

  /// Requests the block transfers of the block identified by [blockId] from the network.
  Future<GetBlockTransfersResult> getBlockTransfers(BlockId blockId) async {
    return _nodeClient.getBlockTransfers(GetBlockTransfersParams(blockId));
  }

  /// Requests a purse’s balance from the network.
  Future<GetBalanceResult> getBalance(Uref purseUref, [String? stateRootHash]) async {
    stateRootHash ??= await getStateRootHash().then((result) => result.stateRootHash);
    return _nodeClient.getBalance(GetBalanceParams(purseUref, stateRootHash!));
  }

  /// Queries a global state and returns the stored value from the network
  Future<QueryGlobalStateResult> queryGlobalState(String key, String hash, bool isBlockHash,
      [List<String> path = const []]) async {
    return _nodeClient.queryGlobalState(QueryGlobalStateParams.fromPair(key, hash, isBlockHash, path));
  }

  /// [Deprecated] Use [queryGlobalState] instead.
  /// Queries a state item and returns the stored value from the network
  Future<GetItemResult> getItem(String key, String stateRootHash, [List<String> path = const []]) async {
    return _nodeClient.getItem(GetItemParams(key, stateRootHash, path));
  }

  /// Requests an [EraInfo] from the network given a switch block.
  /// For a non-switch block this method returns an empty response.
  Future<GetEraInfoBySwitchBlockResult> getEraInfoBySwitchBlock([BlockId? blockId]) async {
    return _nodeClient.getEraInfoBySwitchBlock(GetEraInfoBySwitchBlockParams(blockId));
  }

  /// Requests the bids and validators at a given block.
  Future<GetAuctionInfoResult> getAuctionInfo([BlockId? blockId]) async {
    return _nodeClient.getAuctionInfo(GetAuctionInfoParams(blockId));
  }

  /// Sends a [Deploy] to the network to be executed.
  /// [PutDeployResult] contains the hash of the deploy.
  Future<PutDeployResult> putDeploy(Deploy deploy) async {
    if (deploy.approvals.isEmpty) {
      throw ArgumentError('Deploy must be signed before sending to the network');
    }
    return _nodeClient.putDeploy(PutDeployParams(deploy));
  }
}
