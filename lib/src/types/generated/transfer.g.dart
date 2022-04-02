// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transfer _$TransferFromJson(Map<String, dynamic> json) => Transfer()
  ..amount = BigInt.parse(json['amount'] as String)
  ..deployHash = json['deploy_hash'] as String
  ..from = json['from'] as String
  ..gas = BigInt.parse(json['gas'] as String)
  ..id = json['id'] as int?
  ..source = json['source'] as String
  ..target = json['target'] as String
  ..to = json['to'] as String?;

Map<String, dynamic> _$TransferToJson(Transfer instance) => <String, dynamic>{
      'amount': instance.amount.toString(),
      'deploy_hash': instance.deployHash,
      'from': instance.from,
      'gas': instance.gas.toString(),
      'id': instance.id,
      'source': instance.source,
      'target': instance.target,
      'to': instance.to,
    };
