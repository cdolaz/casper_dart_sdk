import 'dart:convert';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:casper_dart_sdk/casper_sdk.dart';
import 'package:casper_dart_sdk/src/crpyt/key_pair.dart';
import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:test/test.dart';

void main() {
  group("Casper Dart SDK", () {
    group("Deploy Signing", () {
      test("can create a signed deploy with secp256k1", () async {
        final owner = await Secp256k1KeyPair.generate();
        final deploy = Deploy.create(
            DeployHeader.withoutBodyHash(owner.publicKey, DateTime.fromMillisecondsSinceEpoch(1640979000000),
                Duration(minutes: 30), 1, [], "casper-test"),
            ModuleBytesDeployItem.fromAmount(BigInt.from(100000000)),
            TransferDeployItem.transfer(BigInt.from(4500000000), AccountHashKey.fromPublicKey(owner.publicKey)));
        await deploy.sign(owner);
        int approvalCount = 24;
        for (int i = 0; i < approvalCount; i++) {
          final approver = await Secp256k1KeyPair.generate();
          await deploy.sign(approver);
          expect(await deploy.verifySignatures(), isNull);
        }
        expect(deploy.approvals, hasLength(approvalCount + 1));
      });
    });
  });
}
