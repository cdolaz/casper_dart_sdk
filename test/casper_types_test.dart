import 'dart:convert';
import 'dart:math';

import 'package:casper_dart_sdk/src/types/cl_type.dart';
import 'package:casper_dart_sdk/src/types/deploy.dart';
import 'package:casper_dart_sdk/src/types/executable_deploy_item.dart';
import 'package:casper_dart_sdk/src/types/key_algorithm.dart';
import 'package:convert/convert.dart';
import 'package:test/test.dart';

/// Tests for [Deploy] object serialization-deserialization.
void testDeployObjectSerde() {
  test("can deserialize DeployApproval", () {
    final jsonDeployApproval = {
      "signer": "020268d0aee78aee5b0d18d5e518aade42d7d929306db38ad357eaa8c1edbbee702a",
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

/// Tests for [ExecutableDeployItem] object serialization-deserialization.
void testExecutableDeployItemSerde() {
  test("can deserialize ModuleBytesDeployItem from json", () {
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
    ModuleBytesDeployItem moduleBytesDeployItem = ModuleBytesDeployItem.fromJson(jsonModuleBytes["ModuleBytes"]!);

    expect(moduleBytesDeployItem.args.length, 1);
    expect(moduleBytesDeployItem.args[0].name, 'amount');
    String hexStr = hex.encode(moduleBytesDeployItem.args[0].value.bytesAsUint8List);
    expect(hexStr, '0400e1f505');
    expect(moduleBytesDeployItem.args[0].value.parsed, '100000000');
    expect(moduleBytesDeployItem.args[0].value.clTypeDescriptor.type, ClType.u512);
  });

  test("can deserialize StoredContractByNameDeployItem from json", () {
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
        StoredContractByNameDeployItem.fromJson(jsonStoredContractByName["StoredContractByName"]!);

    expect(storedContractByNameDeployItem.args.length, 1);
    expect(storedContractByNameDeployItem.args[0].name, 'quantity');
    expect(storedContractByNameDeployItem.args[0].value.parsed, 1000);
    expect(storedContractByNameDeployItem.args[0].value.clTypeDescriptor.type, ClType.i32);
    expect(storedContractByNameDeployItem.entryPoint, 'example-entry-point');
    expect(storedContractByNameDeployItem.name, 'casper-example');
  });

  test("can deserialize StoredContractByHashDeployItem from json", () {
    final jsonStoredContractByHash = {
      "StoredContractByHash": {
        "args": [
          [
            "delegator",
            {
              "bytes": "01c106652cf627923c0f0370a7d96c8e572e41efefab03c6694598151cc21503f9",
              "parsed": "01c106652cf627923c0f0370a7d96c8e572e41efefab03c6694598151cc21503f9",
              "cl_type": "PublicKey"
            }
          ],
          [
            "validator",
            {
              "bytes": "017d96b9a63abcb61c870a4f55187a0a7ac24096bdb5fc585c12a686a4d892009e",
              "parsed": "017d96b9a63abcb61c870a4f55187a0a7ac24096bdb5fc585c12a686a4d892009e",
              "cl_type": "PublicKey"
            }
          ],
          [
            "amount",
            {"bytes": "0500e8764817", "parsed": "100000000000", "cl_type": "U512"}
          ]
        ],
        "hash": "93d923e336b20a4c4ca14d592b60e5bd3fe330775618290104f9beb326db7ae2",
        "entry_point": "delegate"
      }
    };

    StoredContractByHashDeployItem storedContractByHashDeployItem =
        StoredContractByHashDeployItem.fromJson(jsonStoredContractByHash["StoredContractByHash"]!);

    expect(storedContractByHashDeployItem.args.length, 3);
    expect(storedContractByHashDeployItem.args[0].name, 'delegator');
    expect(storedContractByHashDeployItem.args[0].value.parsed,
        '01c106652cf627923c0f0370a7d96c8e572e41efefab03c6694598151cc21503f9');
    expect(storedContractByHashDeployItem.args[0].value.clTypeDescriptor.type, ClType.publicKey);
    expect(storedContractByHashDeployItem.args[1].name, 'validator');
    expect(storedContractByHashDeployItem.args[1].value.parsed,
        '017d96b9a63abcb61c870a4f55187a0a7ac24096bdb5fc585c12a686a4d892009e');
    expect(storedContractByHashDeployItem.args[1].value.clTypeDescriptor.type, ClType.publicKey);
    expect(storedContractByHashDeployItem.args[2].name, 'amount');
    expect(storedContractByHashDeployItem.args[2].value.parsed, '100000000000');
    expect(storedContractByHashDeployItem.args[2].value.clTypeDescriptor.type, ClType.u512);
    expect(storedContractByHashDeployItem.hash, '93d923e336b20a4c4ca14d592b60e5bd3fe330775618290104f9beb326db7ae2');
    expect(storedContractByHashDeployItem.entryPoint, 'delegate');
  });

  test("can deserialize TransferDeployItem from json", () {
    final jsonTransferDeployItem = {
      "Transfer": {
        "args": [
          [
            "amount",
            {"cl_type": "U512", "bytes": "060006ed7af113", "parsed": "21927870400000"}
          ],
          [
            "target",
            {
              "cl_type": {"ByteArray": 32},
              "bytes": "866fdbaa7875bc41ba7fbe00a04623e78c127f24e85799c64935dd2ef577db55",
              "parsed": "866fdbaa7875bc41ba7fbe00a04623e78c127f24e85799c64935dd2ef577db55"
            }
          ],
          [
            "id",
            {
              "cl_type": {"Option": "U64"},
              "bytes": "0188cbbf7e7e010000",
              "parsed": 1642804005768
            }
          ],
          [
            "targetAccountHex",
            {
              "cl_type": "PublicKey",
              "bytes": "01d6aceccfa3063684901d800b82e16682aaa163b9559985231591d04e43c0e14d",
              "parsed": "01d6aceccfa3063684901d800b82e16682aaa163b9559985231591d04e43c0e14d"
            }
          ]
        ]
      }
    };

    TransferDeployItem transferDeployItem = TransferDeployItem.fromJson(jsonTransferDeployItem["Transfer"]!);

    expect(transferDeployItem.args.length, 4);
    expect(transferDeployItem.args[0].name, 'amount');
    expect(transferDeployItem.args[0].value.parsed, '21927870400000');
    expect(transferDeployItem.args[0].value.clTypeDescriptor.type, ClType.u512);
    expect(transferDeployItem.args[1].name, 'target');
    expect(transferDeployItem.args[1].value.parsed, '866fdbaa7875bc41ba7fbe00a04623e78c127f24e85799c64935dd2ef577db55');
    expect(transferDeployItem.args[1].value.clTypeDescriptor.type, ClType.byteArray);
    expect(transferDeployItem.args[2].name, 'id');
    expect(transferDeployItem.args[2].value.parsed, 1642804005768);
    expect(transferDeployItem.args[2].value.clTypeDescriptor.type, ClType.option);
    expect(transferDeployItem.args[3].name, 'targetAccountHex');
    expect(
        transferDeployItem.args[3].value.parsed, '01d6aceccfa3063684901d800b82e16682aaa163b9559985231591d04e43c0e14d');
    expect(transferDeployItem.args[3].value.clTypeDescriptor.type, ClType.publicKey);
  });
}

/// Tests for [ClTypeDescriptor] object serialization-deserialization.
void testClTypeSerde() {
  test("can deserialize option ClType object from json", () {
    final jsonOptionU64 = {
      "cl_type": {"Option": "U64"}
    };

    final clTypeDescriptor = ClTypeDescriptorJsonConverter().fromJson(jsonOptionU64['cl_type']);
    expect(clTypeDescriptor.type, ClType.option);
    expect((clTypeDescriptor as ClOptionTypeDescriptor).optionType.type, ClType.u64);
  });

  test("can deserialize complex ClType object from json", () {
    final json = {
      "cl_type": {
        "Option": {
          "Map": {
            "key": "U64",
            "value": {
              "Tuple2": [
                "U512",
                {
                  "Result": {"ok": "U64", "err": "U512"}
                }
              ]
            }
          }
        }
      }
    };

    final clTypeDescriptor = ClTypeDescriptorJsonConverter().fromJson(json['cl_type']);
    expect(clTypeDescriptor.type, ClType.option);
    final option = clTypeDescriptor as ClOptionTypeDescriptor;
    expect(option.optionType.type, ClType.map);
    final map = option.optionType as ClMapTypeDescriptor;
    expect(map.keyType.type, ClType.u64);
    expect(map.valueType.type, ClType.tuple2);
    final tuple2 = map.valueType as ClTuple2TypeDescriptor;
    expect(tuple2.firstType.type, ClType.u512);
    expect(tuple2.secondType.type, ClType.result);
    final result = tuple2.secondType as ClResultTypeDescriptor;
    expect(result.okType.type, ClType.u64);
    expect(result.errType.type, ClType.u512);
  });
}

/// Tests for Json object converters
void testJsonConversions() {
  group("Casper Dart SDK", () {
    group("JSON converter", () {
      group("Deploy", () {
        testDeployObjectSerde();
      });
      group("ExecutableDeployItem", () {
        testExecutableDeployItemSerde();
      });

      group("ClType", () {
        testClTypeSerde();
      });
    });
  });
}

void main() {
  testJsonConversions();
}
