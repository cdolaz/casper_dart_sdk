// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../get_deploy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDeployParams _$GetDeployParamsFromJson(Map<String, dynamic> json) =>
    GetDeployParams(
      json['deploy_hash'] as String,
    );

Map<String, dynamic> _$GetDeployParamsToJson(GetDeployParams instance) =>
    <String, dynamic>{
      'deploy_hash': instance.deployHash,
    };

GetDeployResult _$GetDeployResultFromJson(Map<String, dynamic> json) =>
    GetDeployResult(
      json['api_version'],
      Deploy.fromJson(json['deploy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDeployResultToJson(GetDeployResult instance) =>
    <String, dynamic>{
      'api_version': instance.apiVersion,
      'deploy': instance.deploy.toJson(),
    };
