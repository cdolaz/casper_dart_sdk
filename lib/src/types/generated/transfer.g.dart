// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transfer _$TransferFromJson(Map<String, dynamic> json) => Transfer()
  ..amount = BigInt.parse(json['amount'] as String)
  ..deployHash = json['deploy_hash'] as String
  ..from = const AccountHashKeyJsonConverter().fromJson(json['from'] as String)
  ..gas = BigInt.parse(json['gas'] as String)
  ..id = json['id'] as int?
  ..source = const UrefJsonConverter().fromJson(json['source'] as String)
  ..target = const UrefJsonConverter().fromJson(json['target'] as String)
  ..to = json['to'] as String?;

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
      'amount': instance.amount.toString(),
      'deploy_hash': instance.deployHash,
      'from': const AccountHashKeyJsonConverter().toJson(instance.from),
      'gas': instance.gas.toString(),
      'id': instance.id,
      'source': const UrefJsonConverter().toJson(instance.source),
      'target': const UrefJsonConverter().toJson(instance.target),
      'to': instance.to,
    };
