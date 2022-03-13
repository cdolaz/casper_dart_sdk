# Casper Dart SDK

[casper_dart_sdk](https://pub.dev/packages/casper_dart_sdk) is an SDK for interacting with the Casper Blockchain.

## Usage

Since the SDK is under development, it is not available at [pub.dev](https://pub.dev) as of yet. But you can still use it by including the URL of the git repository in your application.

```
dependencies:
  casper_dart_sdk:
    git: 
      url: https://github.com/temiltas/casper_dart_sdk.git
      ref: main
```

## Building

Get dependencies:
```
dart pub get
```

To auto-generate some ser-de classes, run build runner:
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
