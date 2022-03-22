# Casper Dart SDK

The Dart package casper_dart_sdk is an SDK for interacting with the Casper Blockchain.

## Requirements
To use the SDK, you will need to have the following tools installed:
- [Dart SDK](https://dart.dev/get-dart) version 2.16.1 or higher (haven't been tested before 2.16.1)

## Installation

Since the SDK is under development, it is not available at [pub.dev](https://pub.dev) as of yet. But you can still use it by including the URL of the git repository in your application.

```
dependencies:
  casper_dart_sdk:
    git: 
      url: https://github.com/cdolaz/casper_dart_sdk.git
      ref: main
```

## Usage
After importing via:
```dart
import 'package:casper_dart_sdk/casper_sdk.dart';
```

Use the `CasperClient` class to interact with the Casper Blockchain.
```dart
final client = CasperClient(Uri.parse("http://138.201.54.44:7777/rpc")); // Pass the node's RPC endpoint
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
dart pub run build_runner build
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
