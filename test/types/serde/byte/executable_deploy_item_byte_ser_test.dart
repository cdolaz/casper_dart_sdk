import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:convert/convert.dart';
import 'package:test/test.dart';

void main() {
  group("ExecutableDeployItem byte serialization", () {
    // Some tests are adapted from Casper .NET SDK.
    test("ModuleBytesDeployItem(1000) correctly serializes to bytes", () {
      final deployItem = ModuleBytesDeployItem.fromAmount(BigInt.from(1000));
      expect(hex.encode(deployItem.toBytes()), "00000000000100000006000000616d6f756e740300000002e80308");
    });

    test("A sample StoredContractByHashDeployItem correctly serializes to bytes", () {
      final hashKey = HashKey("0102030401020304010203040102030401020304010203040102030401020304");
      final deployItem = StoredContractByHashDeployItem(hashKey.toHex(), "counter_inc");
      expect(hex.encode(deployItem.toBytes()),
          "0101020304010203040102030401020304010203040102030401020304010203040b000000636f756e7465725f696e6300000000");
    });

    test("A sample StoredContractByNameDeployItem correctly serializes to bytes", () {
      final deployItem = StoredContractByNameDeployItem("counter", "counter_inc");
      expect(hex.encode(deployItem.toBytes()), "0207000000636f756e7465720b000000636f756e7465725f696e6300000000");
    });

    test("A sample StoredVersionedContractByHashDeployItem correctly serializes to bytes", () {
      final hashKey = HashKey("0102030401020304010203040102030401020304010203040102030401020304");
      final deployItem = StoredVersionedContractByHashDeployItem(hashKey.toHex(), 1, "counter_inc");
      expect(hex.encode(deployItem.toBytes()),
          "03010203040102030401020304010203040102030401020304010203040102030401010000000b000000636f756e7465725f696e6300000000");
    });

    test("A sample StoredVersionedContractByNameDeployItem correctly serializes to bytes", () {
      final deployItem = StoredVersionedContractByNameDeployItem("counter", 15, "counter_inc");
      expect(hex.encode(deployItem.toBytes()), "0407000000636f756e746572010f0000000b000000636f756e7465725f696e6300000000");
    });

    test("A sample TransferDeployItem correctly serializes to bytes", () {
      final publicKey = PublicKey.fromHex("01027c04a0210afdf4a83328d57e8c2a12247a86d872fb53367f22a84b1b53d2a9");
      final transfer = TransferDeployItem.transfer(BigInt.from(15000000000), AccountHashKey.fromPublicKey(publicKey), 12345);
      expect(hex.encode(transfer.toBytes()),
          "050300000006000000616d6f756e74060000000500d6117e03"
          "0806000000746172676574200000007cfcb2fbdd0e747cabd0"
          "f8fe4d743179a764a8d7174ea6f0dfdb0c41fe1348b40f2000"
          "0000020000006964090000000139300000000000000d05");
    });
  });
}
