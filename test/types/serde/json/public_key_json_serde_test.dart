import 'package:test/test.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';

void main() {
  group("PublicKey JSON ser-de", () {
    test("PublicKey list converter successfully deserializes from json", () {
      final json = {
        "list": [
          "016e7a1cdd29b0b78fd13af4c5598feff4ef2a97166e3ca6f2e4fbfccd80505bf1",
          "018a875fff1eb38451577acd5afee405456568dd7c89e090863a0557bc7af49f17",
        ]
      };

      final list = PublicKeyJsonListConverter().fromJson(json['list']!);
      expect(list.length, 2);
      expect(list[0].accountHex.toLowerCase(), '016e7a1cdd29b0b78fd13af4c5598feff4ef2a97166e3ca6f2e4fbfccd80505bf1');
      expect(list[1].accountHex.toLowerCase(), '018a875fff1eb38451577acd5afee405456568dd7c89e090863a0557bc7af49f17');
    });

    test("PublicKey list converter successfully deserializes from empty json list", () {
      final json = {"list": []};

      final list = PublicKeyJsonListConverter().fromJson(json['list']!);
      expect(list.length, 0);
    });

    test("PublicKey list converter successfully serializes to json", () {
      List<PublicKey> list = [];
      list.add(PublicKey.fromHex('016e7a1cdd29b0b78fd13af4c5598feff4ef2a97166e3ca6f2e4fbfccd80505bf1'));
      list.add(PublicKey.fromHex('018a875fff1eb38451577acd5afee405456568dd7c89e090863a0557bc7af49f17'));

      final jsonList = PublicKeyJsonListConverter().toJson(list);
      expect(jsonList.length, 2);
      expect(jsonList[0].toLowerCase(), '016e7a1cdd29b0b78fd13af4c5598feff4ef2a97166e3ca6f2e4fbfccd80505bf1');
      expect(jsonList[1].toLowerCase(), '018a875fff1eb38451577acd5afee405456568dd7c89e090863a0557bc7af49f17');
    });
  });
}
