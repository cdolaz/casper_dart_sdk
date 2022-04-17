// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      json['contract_package_hash'] as String,
      json['contract_wasm_hash'] as String,
      (json['entry_points'] as List<dynamic>)
          .map((e) => EntryPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['named_keys'] as List<dynamic>)
          .map((e) => NamedKey.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['protocol_version'] as String,
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'contract_package_hash': instance.contractPackageHash,
      'contract_wasm_hash': instance.contractWasmHash,
      'entry_points': instance.entryPoints,
      'named_keys': instance.namedKeys,
      'protocol_version': instance.protocolVersion,
    };

ContractPackage _$ContractPackageFromJson(Map<String, dynamic> json) =>
    ContractPackage(
      const UrefJsonConverter().fromJson(json['access_key'] as String),
      (json['disabled_versions'] as List<dynamic>)
          .map((e) => DisabledVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['groups'] as List<dynamic>)
          .map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['versions'] as List<dynamic>)
          .map((e) => ContractVersion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContractPackageToJson(ContractPackage instance) =>
    <String, dynamic>{
      'access_key': const UrefJsonConverter().toJson(instance.accessKey),
      'disabled_versions': instance.disabledVersions,
      'groups': instance.groups,
      'versions': instance.versions,
    };

EntryPoint _$EntryPointFromJson(Map<String, dynamic> json) => EntryPoint(
      const EntryPointAccessJsonConverter().fromJson(json['access']),
      (json['args'] as List<dynamic>)
          .map((e) => Parameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      $enumDecode(_$EntryPointTypeEnumMap, json['entry_point_type']),
      json['name'] as String,
      const ClTypeDescriptorJsonConverter().fromJson(json['ret']),
    );

Map<String, dynamic> _$EntryPointToJson(EntryPoint instance) =>
    <String, dynamic>{
      'access': const EntryPointAccessJsonConverter().toJson(instance.access),
      'args': instance.args,
      'entry_point_type': _$EntryPointTypeEnumMap[instance.entryPointType],
      'name': instance.name,
      'ret': const ClTypeDescriptorJsonConverter().toJson(instance.returnType),
    };

const _$EntryPointTypeEnumMap = {
  EntryPointType.session: 'Session',
  EntryPointType.contract: 'Contract',
};

Parameter _$ParameterFromJson(Map<String, dynamic> json) => Parameter(
      json['name'] as String,
      const ClTypeDescriptorJsonConverter().fromJson(json['cl_type']),
    );

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
      'name': instance.name,
      'cl_type': const ClTypeDescriptorJsonConverter().toJson(instance.clType),
    };

DisabledVersion _$DisabledVersionFromJson(Map<String, dynamic> json) =>
    DisabledVersion(
      json['contract_version'] as int,
      json['protocol_version_major'] as int,
    );

Map<String, dynamic> _$DisabledVersionToJson(DisabledVersion instance) =>
    <String, dynamic>{
      'contract_version': instance.contractVersion,
      'protocol_version_major': instance.protocolVersionMajor,
    };

ContractVersion _$ContractVersionFromJson(Map<String, dynamic> json) =>
    ContractVersion(
      json['contract_hash'] as String,
      json['contract_version'] as int,
      json['protocol_version_major'] as int,
    );

Map<String, dynamic> _$ContractVersionToJson(ContractVersion instance) =>
    <String, dynamic>{
      'contract_hash': instance.contractHash,
      'contract_version': instance.contractVersion,
      'protocol_version_major': instance.protocolVersionMajor,
    };

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      json['group'] as String,
      const UrefJsonListConverter().fromJson(json['keys'] as List),
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'group': instance.label,
      'keys': const UrefJsonListConverter().toJson(instance.keys),
    };
