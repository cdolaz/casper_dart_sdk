// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../era.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EraInfo _$EraInfoFromJson(Map<String, dynamic> json) => EraInfo(
      const SeigniorageAllocationJsonListConverter()
          .fromJson(json['seigniorage_allocations'] as List),
    );

Map<String, dynamic> _$EraInfoToJson(EraInfo instance) => <String, dynamic>{
      'seigniorage_allocations': const SeigniorageAllocationJsonListConverter()
          .toJson(instance.seigniorageAllocations),
    };

EraSummary _$EraSummaryFromJson(Map<String, dynamic> json) => EraSummary(
      json['block_hash'] as String,
      json['era_id'] as int,
      const StoredValueJsonConverter()
          .fromJson(json['stored_value'] as Map<String, dynamic>),
      json['state_root_hash'] as String,
      json['merkle_proof'] as String,
    );

Map<String, dynamic> _$EraSummaryToJson(EraSummary instance) =>
    <String, dynamic>{
      'block_hash': instance.blockHash,
      'era_id': instance.eraId,
      'stored_value':
          const StoredValueJsonConverter().toJson(instance.storedValue),
      'state_root_hash': instance.stateRootHash,
      'merkle_proof': instance.merkleProof,
    };
