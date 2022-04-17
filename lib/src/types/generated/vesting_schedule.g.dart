// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../vesting_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VestingSchedule _$VestingScheduleFromJson(Map<String, dynamic> json) =>
    VestingSchedule(
      json['initial_release_timestamp_millis'] as int,
      (json['locked_amounts'] as List<dynamic>)
          .map((e) => BigInt.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$VestingScheduleToJson(VestingSchedule instance) =>
    <String, dynamic>{
      'initial_release_timestamp_millis':
          instance.initialReleaseTimestampMillis,
      'locked_amounts':
          instance.lockedAmounts.map((e) => e.toString()).toList(),
    };
