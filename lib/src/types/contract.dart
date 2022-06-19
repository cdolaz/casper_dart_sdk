import 'package:json_annotation/json_annotation.dart';

import 'package:casper_dart_sdk/src/types/cl_type.dart';
import 'package:casper_dart_sdk/src/types/global_state_key.dart';
import 'package:casper_dart_sdk/src/types/named_key.dart';

part 'generated/contract.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Contract {
  String contractPackageHash;
  String contractWasmHash;
  List<EntryPoint> entryPoints;
  List<NamedKey> namedKeys;
  String protocolVersion;

  factory Contract.fromJson(Map<String, dynamic> json) => _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);

  Contract(this.contractPackageHash, this.contractWasmHash, this.entryPoints, this.namedKeys, this.protocolVersion);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ContractPackage {
  @UrefJsonConverter()
  Uref accessKey;

  List<DisabledVersion> disabledVersions;

  List<Group> groups;

  List<ContractVersion> versions;

  factory ContractPackage.fromJson(Map<String, dynamic> json) => _$ContractPackageFromJson(json);
  Map<String, dynamic> toJson() => _$ContractPackageToJson(this);

  ContractPackage(this.accessKey, this.disabledVersions, this.groups, this.versions);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class EntryPoint {
  @EntryPointAccessJsonConverter()
  EntryPointAccess access;

  List<Parameter> args;

  EntryPointType entryPointType;

  String name;

  @ClTypeDescriptorJsonConverter()
  @JsonKey(name: 'ret')
  ClTypeDescriptor returnType;

  factory EntryPoint.fromJson(Map<String, dynamic> json) => _$EntryPointFromJson(json);
  Map<String, dynamic> toJson() => _$EntryPointToJson(this);

  EntryPoint(this.access, this.args, this.entryPointType, this.name, this.returnType);
}

class EntryPointAccess {
  bool isPublic;

  List<String>? groups;

  EntryPointAccess(this.isPublic, this.groups);
}

class EntryPointAccessJsonConverter extends JsonConverter<EntryPointAccess, dynamic> {
  const EntryPointAccessJsonConverter();

  @override
  EntryPointAccess fromJson(dynamic json) {
    if (json is String) {
      return EntryPointAccess(json == 'public', null);
    } else if (json is Map) {
      return EntryPointAccess(false, json['groups']);
    } else {
      throw ArgumentError.value(json, 'json', 'Unable to deserialize EntryPointAccess');
    }
  }

  @override
  dynamic toJson(EntryPointAccess object) {
    if (object.groups == null) {
      return object.isPublic ? 'public' : '';
    } else {
      return {'groups': object.groups};
    }
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Parameter {
  String name;

  @ClTypeDescriptorJsonConverter()
  ClTypeDescriptor clType;

  factory Parameter.fromJson(Map<String, dynamic> json) => _$ParameterFromJson(json);
  Map<String, dynamic> toJson() => _$ParameterToJson(this);

  Parameter(this.name, this.clType);
}

enum EntryPointType {
  @JsonValue('Session')
  session,
  @JsonValue('Contract')
  contract,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DisabledVersion {
  int contractVersion;
  int protocolVersionMajor;

  factory DisabledVersion.fromJson(Map<String, dynamic> json) => _$DisabledVersionFromJson(json);
  Map<String, dynamic> toJson() => _$DisabledVersionToJson(this);

  DisabledVersion(this.contractVersion, this.protocolVersionMajor);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ContractVersion {
  String contractHash;

  int contractVersion;

  int protocolVersionMajor;

  factory ContractVersion.fromJson(Map<String, dynamic> json) => _$ContractVersionFromJson(json);
  Map<String, dynamic> toJson() => _$ContractVersionToJson(this);

  ContractVersion(this.contractHash, this.contractVersion, this.protocolVersionMajor);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Group {
  @JsonKey(name: 'group')
  String label;

  @UrefJsonListConverter()
  List<Uref> keys;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);

  Group(this.label, this.keys);
}
