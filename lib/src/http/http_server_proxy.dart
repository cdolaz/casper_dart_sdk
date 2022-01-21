import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:jsonrpc2/jsonrpc2.dart';

///  Each argument in the call must be representable in json
///  or have a toJson() method.
///
///  Exceptions on the remote end will throw RpcException.
class JsonRpcHttpServerProxy extends ServerProxyBase {
  Map<String, String> additionalHeaders;

  JsonRpcHttpServerProxy(url,
      [this.additionalHeaders = const <String, String>{}])
      : super(url);

  /// Return a Future with the JSON-RPC response
  @override
  Future<String> transmit(String package) async {
    var headers = {'Content-Type': 'application/json'};
    if (additionalHeaders.isNotEmpty) {
      headers.addAll(additionalHeaders);
    }

    // CAUTION: Because Dart's http library lowercases all headers,
    // and the servers can be case-sensitive (although RFC for HTTP states it should be case-insensitive),
    // we need to use lower level HttpClient to send the post request.
    final client = HttpClient();
    final request = await client.postUrl(resource);
    request.headers.add('Content-Type', 'application/json');
    request.add(utf8.encode(package));
    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();
    if (response.statusCode == 204 || body.isEmpty) {
      return '';
    } else {
      return body;
    }
  }
}

/// See the documentation in [BatchServerProxyBase]
class BatchJsonRpcHttpServerProxy extends BatchServerProxyBase {
  /// constructor
  BatchJsonRpcHttpServerProxy(String url,
      [additionalHeaders = const <String, String>{}]) {
    super.proxy = JsonRpcHttpServerProxy(url, additionalHeaders);
  }
}
