import 'package:casper_dart_sdk/src/http/http_server_proxy.dart';
import 'package:casper_dart_sdk/src/jsonrpc/results/get_peers_result.dart';

class CasperNodeRpcClient extends JsonRpcHttpServerProxy {
  CasperNodeRpcClient(url) : super(url, {'User-Agent': 'CasperDart/0.1'});

  Future<GetPeersResult> getPeers() async {
    return GetPeersResult.fromJson(await call('info_get_peers'));
  }
}
