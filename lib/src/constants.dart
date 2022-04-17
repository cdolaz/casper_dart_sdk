class RpcMethodName {
  static const String rpcDiscover = 'rpc.discover';

  // Info
  static const String infoGetPeers = "info_get_peers";
  static const String infoGetDeploy = "info_get_deploy";
  static const String infoGetStatus = "info_get_status";

  // Chain
  static const String chainGetStateRootHash = "chain_get_state_root_hash";
  static const String chainGetBlock = "chain_get_block";
  static const String chainGetBlockTransfers = "chain_get_block_transfers";

  // State
  static const String stateGetBalance = "state_get_balance";
  static const String queryGlobalState = "query_global_state";
}
