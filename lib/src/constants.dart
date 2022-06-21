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
  static const String chainGetEraInfoBySwitchBlock = "chain_get_era_info_by_switch_block";

  // State
  static const String stateGetBalance = "state_get_balance";
  static const String queryGlobalState = "query_global_state";
  static const String stateGetItem = "state_get_item";
  static const String stateGetAuctionInfo = "state_get_auction_info";
  static const String stateGetDictionaryItem = "state_get_dictionary_item";

  // Account
  static const String accountPutDeploy = "account_put_deploy";
}
