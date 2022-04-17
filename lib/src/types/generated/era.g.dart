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
