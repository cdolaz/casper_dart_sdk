// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../deploy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deploy _$DeployFromJson(Map<String, dynamic> json) => Deploy(
      const Cep57ChecksummedHexJsonConverter().fromJson(json['hash'] as String),
      DeployHeader.fromJson(json['header'] as Map<String, dynamic>),
      const ExecutableDeployItemJsonConverter()
          .fromJson(json['payment'] as Map<String, dynamic>),
      const ExecutableDeployItemJsonConverter()
          .fromJson(json['session'] as Map<String, dynamic>),
      (json['approvals'] as List<dynamic>)
          .map((e) => DeployApproval.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeployToJson(Deploy instance) => <String, dynamic>{
      'hash': const Cep57ChecksummedHexJsonConverter().toJson(instance.hash),
      'header': instance.header,
      'payment':
          const ExecutableDeployItemJsonConverter().toJson(instance.payment),
      'session':
          const ExecutableDeployItemJsonConverter().toJson(instance.session),
      'approvals': instance.approvals,
    };

DeployHeader _$DeployHeaderFromJson(Map<String, dynamic> json) => DeployHeader(
      const ClPublicKeyJsonConverter().fromJson(json['account'] as String),
      const DateTimeJsonConverter().fromJson(json['timestamp'] as String),
      const HumanReadableDurationJsonConverter()
          .fromJson(json['ttl'] as String),
      json['gas_price'] as int,
      const Cep57ChecksummedHexJsonConverter()
          .fromJson(json['body_hash'] as String),
      (json['dependencies'] as List<dynamic>).map((e) => e as String).toList(),
      json['chain_name'] as String,
    );

Map<String, dynamic> _$DeployHeaderToJson(DeployHeader instance) =>
    <String, dynamic>{
      'account': const ClPublicKeyJsonConverter().toJson(instance.account),
      'timestamp': const DateTimeJsonConverter().toJson(instance.timestamp),
      'ttl': const HumanReadableDurationJsonConverter().toJson(instance.ttl),
      'gas_price': instance.gasPrice,
      'body_hash':
          const Cep57ChecksummedHexJsonConverter().toJson(instance.bodyHash),
      'dependencies': instance.dependencies,
      'chain_name': instance.chainName,
    };

DeployApproval _$DeployApprovalFromJson(Map<String, dynamic> json) =>
    DeployApproval(
      const SignatureJsonConverter().fromJson(json['signature'] as String),
      const ClPublicKeyJsonConverter().fromJson(json['signer'] as String),
    );

Map<String, dynamic> _$DeployApprovalToJson(DeployApproval instance) =>
    <String, dynamic>{
      'signature': const SignatureJsonConverter().toJson(instance.signature),
      'signer': const ClPublicKeyJsonConverter().toJson(instance.signer),
    };

DeployInfo _$DeployInfoFromJson(Map<String, dynamic> json) => DeployInfo(
      json['deploy_hash'] as String,
      const AccountHashKeyJsonConverter().fromJson(json['from'] as String),
      BigInt.parse(json['gas'] as String),
      const UrefJsonConverter().fromJson(json['source'] as String),
      (json['transfers'] as List<dynamic>)
          .map((e) => const TransferKeyJsonConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$DeployInfoToJson(DeployInfo instance) =>
    <String, dynamic>{
      'deploy_hash': instance.deployHash,
      'from': const AccountHashKeyJsonConverter().toJson(instance.from),
      'gas': instance.gas.toString(),
      'source': const UrefJsonConverter().toJson(instance.source),
      'transfers': instance.transfers
          .map(const TransferKeyJsonConverter().toJson)
          .toList(),
    };
