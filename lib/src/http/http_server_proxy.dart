import 'dart:async';
import 'dart:convert';

import 'package:jsonrpc2/jsonrpc2.dart';
import 'package:http/http.dart' as http;

///  Exceptions on the remote end will throw RpcException.
class JsonRpcHttpServerProxy extends ServerProxyBase {
  Map<String, String> additionalHeaders;

  JsonRpcHttpServerProxy(url, [this.additionalHeaders = const <String, String>{}]) : super(url);

  /// Returns a Future with the JSON-RPC response
  @override
  Future<String> transmit(String package) async {
    var headers = {'Content-Type': 'application/json'};
    if (additionalHeaders.isNotEmpty) {
      headers.addAll(additionalHeaders);
    }

    var response = await http.post(resource, body: utf8.encode(package), headers: headers);
    final body = response.body;

    if (response.statusCode == 204 || body.isEmpty) {
      return '';
    } else {
      return body;
    }
  }

  /// Returns a Future with raw string response from the RPC server
  Future<String> callRaw(String method, [dynamic params]) async {
    var package = json.encode(JsonRpcMethod(method, params, serverVersion: "2.0"));

    var resp = await transmit(package);
    return resp;
  }
}

/// See the documentation in [BatchServerProxyBase]
class BatchJsonRpcHttpServerProxy extends BatchServerProxyBase {
  /// constructor
  BatchJsonRpcHttpServerProxy(String url, [additionalHeaders = const <String, String>{}]) {
    super.proxy = JsonRpcHttpServerProxy(url, additionalHeaders);
  }
}
