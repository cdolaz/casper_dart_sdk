// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../deploy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeployApproval _$DeployApprovalFromJson(Map<String, dynamic> json) =>
    DeployApproval(
      const SignatureJsonConverter().fromJson(json['signature'] as String),
      const PublicKeyJsonConverter().fromJson(json['signer'] as String),
    );

Map<String, dynamic> _$DeployApprovalToJson(DeployApproval instance) =>
    <String, dynamic>{
      'signature': const SignatureJsonConverter().toJson(instance.signature),
      'signer': const PublicKeyJsonConverter().toJson(instance.signer),
    };

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
      const PublicKeyJsonConverter().fromJson(json['account'] as String),
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
      'account': const PublicKeyJsonConverter().toJson(instance.account),
      'timestamp': const DateTimeJsonConverter().toJson(instance.timestamp),
      'ttl': const HumanReadableDurationJsonConverter().toJson(instance.ttl),
      'gas_price': instance.gasPrice,
      'body_hash':
          const Cep57ChecksummedHexJsonConverter().toJson(instance.bodyHash),
      'dependencies': instance.dependencies,
      'chain_name': instance.chainName,
    };
