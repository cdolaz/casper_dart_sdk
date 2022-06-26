# Casper Dart SDK

The Dart package casper_dart_sdk is an SDK for interacting with the Casper Blockchain.

## Requirements
To use the SDK, you will need to have the following tools installed:
- [Dart SDK](https://dart.dev/get-dart) version 2.16.1 or higher (haven't been tested before 2.16.1)

## Installation

Available at [pub.dev](https://pub.dev/packages/casper_dart_sdk).

```
dependencies:
  casper_dart_sdk: ^0.1.3
```

## Usage
After importing via:
```dart
import 'package:casper_dart_sdk/casper_dart_sdk.dart';
```

Use the `CasperClient` class to interact with the Casper Blockchain.

For example:
```dart
// Pass the node's RPC endpoint
final client = CasperClient(Uri.parse("http://127.0.0.1:7777/rpc"));

client.getPeers().then((result) {
  for (final peer in result.peers) {
    print(peer.address);
  }
});
```

The [usage.md](./doc/usage.md) document contains more information about the usage of the SDK.

## Development

### Building

Get dependencies:
```
dart pub get
```

To auto-generate serialization-deserialization classes, run build runner:
```
dart run build_runner build
```

### Testing

Run all tests: 

```
dart test
```

Run specific test file:

```
dart test test/utils_test.dart
```

#### Test Environment
The environment variable `CASPER_TEST_NODE_RPC_URL` must be set to run the tests. Bare in mind that currently, some of the tests might be specific to the test node `http://138.201.54.44:7777/rpc`. The server responses should be mocked instead of relying on a single test node.