import 'dart:convert';
import 'dart:math';

import 'package:casper_dart_sdk/src/types/cl_type.dart';
import 'package:casper_dart_sdk/src/types/deploy.dart';
import 'package:casper_dart_sdk/src/types/executable_deploy_item.dart';
import 'package:casper_dart_sdk/src/types/key_algorithm.dart';
import 'package:convert/convert.dart';
import 'package:test/test.dart';

/// Tests for serialization and deserialization of [Deploy] objects
void testDeployObjectSerDe() {
  test('Can deserialize DeployApproval', () {
    final jsonDeployApproval = {
      "signer":
          "020268d0aee78aee5b0d18d5e518aade42d7d929306db38ad357eaa8c1edbbee702a",
      "signature":
          "02165e788a00cb25cfe453fdba335a98c496f25120a9a47c2b6c9cb89f32550bb2431acea28112affb4f6ce840728769e278806948f61b5a11158dd07c733deed7"
    };

    final deployApproval = DeployApproval.fromJson(jsonDeployApproval);
    expect(deployApproval.signature.keyAlgorithm, KeyAlgorithm.secp256k1);
    expect(deployApproval.signature.toHex().toLowerCase(),
        '02165e788a00cb25cfe453fdba335a98c496f25120a9a47c2b6c9cb89f32550bb2431acea28112affb4f6ce840728769e278806948f61b5a11158dd07c733deed7');
    expect(deployApproval.signer.keyAlgorithm, KeyAlgorithm.secp256k1);
    expect(deployApproval.signer.accountHex.toLowerCase(),
        '020268d0aee78aee5b0d18d5e518aade42d7d929306db38ad357eaa8c1edbbee702a');
  });
}

/// Tests for Json object converters
void testJsonConversions() {
  test("Can convert human readable duration to Duration object", () {
    String humanReadableDuration = '1hours 30m';
    Duration duration = DurationJsonConverter().fromJson(humanReadableDuration);
    expect(duration.inMinutes, 90);
  });

  test("Can convert Duration object to human readable duration", () {
    Duration duration = Duration(minutes: 90);
    String humanReadableDuration = DurationJsonConverter().toJson(duration);
    expect(humanReadableDuration, '1h 30m');
  });

  test('Can deserialize ModuleBytesDeployItem from json', () {
    final jsonModuleBytes = {
      "ModuleBytes": {
        "args": [
          [
            "amount",
            {"bytes": "0400e1f505", "parsed": "100000000", "cl_type": "U512"}
          ]
        ],
        "module_bytes": ""
      }
    };
    ModuleBytesDeployItem moduleBytesDeployItem =
        ModuleBytesDeployItem.fromJson(jsonModuleBytes["ModuleBytes"]!);

    expect(moduleBytesDeployItem.args.length, 1);
    expect(moduleBytesDeployItem.args[0].name, 'amount');
    String hexStr =
        hex.encode(moduleBytesDeployItem.args[0].value.bytesAsUint8List);
    expect(hexStr, '0400e1f505');
    expect(moduleBytesDeployItem.args[0].value.parsed, '100000000');
    expect(moduleBytesDeployItem.args[0].value.clType, ClType.u512);
  });

  test('Can deserialize StoredContractByNameDeployItem from json', () {
    final jsonStoredContractByName = {
      "StoredContractByName": {
        "args": [
          [
            "quantity",
            {"bytes": "e8030000", "cl_type": "I32", "parsed": 1000}
          ]
        ],
        "entry_point": "example-entry-point",
        "name": "casper-example"
      }
    };

    StoredContractByNameDeployItem storedContractByNameDeployItem =
        StoredContractByNameDeployItem.fromJson(
            jsonStoredContractByName["StoredContractByName"]!);
    
    expect(storedContractByNameDeployItem.args.length, 1);
    expect(storedContractByNameDeployItem.args[0].name, 'quantity');
    expect(storedContractByNameDeployItem.args[0].value.parsed, 1000);
    expect(storedContractByNameDeployItem.args[0].value.clType, ClType.i32);
    expect(storedContractByNameDeployItem.entryPoint, 'example-entry-point');
    expect(storedContractByNameDeployItem.name, 'casper-example');
  });
}

void main() {
  testDeployObjectSerDe();
  testJsonConversions();
}
