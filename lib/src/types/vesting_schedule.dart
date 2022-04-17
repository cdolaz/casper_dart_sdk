import 'package:json_annotation/json_annotation.dart';

part 'generated/vesting_schedule.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VestingSchedule {
  int initialReleaseTimestampMillis;

  List<BigInt> lockedAmounts;

  factory VestingSchedule.fromJson(Map<String, dynamic> json) => _$VestingScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$VestingScheduleToJson(this);

  VestingSchedule(this.initialReleaseTimestampMillis, this.lockedAmounts);
}