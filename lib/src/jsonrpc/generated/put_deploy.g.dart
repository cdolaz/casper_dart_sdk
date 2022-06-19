// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../put_deploy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutDeployParams _$PutDeployParamsFromJson(Map<String, dynamic> json) =>
    PutDeployParams(
      Deploy.fromJson(json['deploy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PutDeployParamsToJson(PutDeployParams instance) =>
    <String, dynamic>{
      'deploy': instance.deploy.toJson(),
    };

PutDeployResult _$PutDeployResultFromJson(Map<String, dynamic> json) =>
    PutDeployResult(
      json['api_version'],
      json['deploy_hash'] as String,
    );

Map<String, dynamic> _$PutDeployResultToJson(PutDeployResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'deploy_hash': instance.deployHash,
    };
