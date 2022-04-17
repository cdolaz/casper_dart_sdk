// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      const AccountHashKeyJsonConverter()
          .fromJson(json['account_hash'] as String),
      ActionThresholds.fromJson(
          json['action_thresholds'] as Map<String, dynamic>),
      (json['associated_keys'] as List<dynamic>)
          .map((e) => AssociatedKey.fromJson(e as Map<String, dynamic>))
          .toList(),
      const UrefJsonConverter().fromJson(json['main_purse'] as String),
      (json['named_keys'] as List<dynamic>)
          .map((e) => NamedKey.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'account_hash':
          const AccountHashKeyJsonConverter().toJson(instance.accountHash),
      'action_thresholds': instance.actionThresholds,
      'associated_keys': instance.associatedKeys,
      'main_purse': const UrefJsonConverter().toJson(instance.mainPurse),
      'named_keys': instance.namedKeys,
    };

ActionThresholds _$ActionThresholdsFromJson(Map<String, dynamic> json) =>
    ActionThresholds(
      json['deployment'] as int,
      json['key_management'] as int,
    );

Map<String, dynamic> _$ActionThresholdsToJson(ActionThresholds instance) =>
    <String, dynamic>{
      'deployment': instance.deployment,
      'key_management': instance.keyManagement,
    };

AssociatedKey _$AssociatedKeyFromJson(Map<String, dynamic> json) =>
    AssociatedKey(
      const AccountHashKeyJsonConverter()
          .fromJson(json['account_hash'] as String),
      json['weight'] as int,
    );

Map<String, dynamic> _$AssociatedKeyToJson(AssociatedKey instance) =>
    <String, dynamic>{
      'account_hash':
          const AccountHashKeyJsonConverter().toJson(instance.accountHash),
      'weight': instance.weight,
    };
