# Casper Dart SDK

The Dart package casper_dart_sdk is an SDK for interacting with the Casper Blockchain.

## Requirements
To use the SDK, you will need to have the following tools installed:
- [Dart SDK](https://dart.dev/get-dart) version 2.16.1 or higher (haven't been tested before 2.16.1)

## Installation

Available at [pub.dev](https://pub.dev/packages/casper_dart_sdk).

```
dependencies:
  casper_dart_sdk: ^0.1.0
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

## Building

Get dependencies:
```
dart pub get
```

To auto-generate serialization-deserialization classes, run build runner:
```
dart run build_runner build
```

## Testing

Run all tests: 

```
dart test
```

Run specific test file:

```
dart test test/utils_test.dart
```
