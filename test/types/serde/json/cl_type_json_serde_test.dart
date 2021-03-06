import 'package:casper_dart_sdk/src/types/cl_type.dart';
import 'package:test/test.dart';

void main() {
  group("ClType JSON ser-de", () {
    test("can deserialize option ClType object from json", () {
      final jsonOptionU64 = {
        "cl_type": {"Option": "U64"}
      };

      final clTypeDescriptor = ClTypeDescriptorJsonConverter().fromJson(jsonOptionU64['cl_type']);
      expect(clTypeDescriptor.type, ClType.option);
      expect((clTypeDescriptor as ClOptionTypeDescriptor).optionType.type, ClType.u64);
    });

    final complexClType = {
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

    test("can deserialize complex ClType object from json", () {
      final clTypeDescriptor = ClTypeDescriptorJsonConverter().fromJson(complexClType['cl_type']);
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

    test("can serialize complex ClType object to json", () {
      final clTypeDescriptor = ClOptionTypeDescriptor(ClMapTypeDescriptor(
          ClTypeDescriptor(ClType.u64),
          ClTuple2TypeDescriptor(ClTypeDescriptor(ClType.u512),
              ClResultTypeDescriptor(ClTypeDescriptor(ClType.u64), ClTypeDescriptor(ClType.u512)))));
      final json = ClTypeDescriptorJsonConverter().toJson(clTypeDescriptor);
      expect(json, complexClType['cl_type']);
    });
  });
}
