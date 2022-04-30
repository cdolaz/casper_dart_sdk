import 'package:casper_dart_sdk/src/types/deploy.dart';
import 'package:casper_dart_sdk/src/types/key_algorithm.dart';
import 'package:test/test.dart';

void main() {
  group("Deploy JSON ser-de", () {
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
  });
}
