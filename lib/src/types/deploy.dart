import 'dart:typed_data';

import 'package:casper_dart_sdk/src/helpers/checksummed_hex.dart';
import 'package:casper_dart_sdk/src/helpers/string_utils.dart';
import 'package:casper_dart_sdk/src/types/public_key.dart';
import 'package:casper_dart_sdk/src/types/signature.dart';
import 'package:json_annotation/json_annotation.dart';

import 'executable_deploy_item.dart';

part 'deploy.g.dart';

@JsonSerializable()
class DeployApproval {
  @JsonKey(name: 'signature')
  @SignatureJsonConverter()
  Signature signature;

  @JsonKey(name: 'signer')
  @PublicKeyJsonConverter()
  PublicKey signer;

  factory DeployApproval.fromJson(Map<String, dynamic> json) =>
      _$DeployApprovalFromJson(json);

  Map<String, dynamic> toJson() => _$DeployApprovalToJson(this);

  DeployApproval(this.signature, this.signer);
}

@JsonSerializable()
class Deploy {
  @JsonKey(name: 'hash')
  @Cep57ChecksummedHexJsonConverter()
  String hash;

  @JsonKey(name: 'header')
  DeployHeader header;

  @JsonKey(name: 'payment')
  @ExecutableDeployItemJsonConverter()
  ExecutableDeployItem payment;

  @JsonKey(name: 'session')
  @ExecutableDeployItemJsonConverter()
  ExecutableDeployItem session;

  @JsonKey(name: 'approvals')
  List<DeployApproval> approvals;

  factory Deploy.fromJson(Map<String, dynamic> json) => _$DeployFromJson(json);
  Map<String, dynamic> toJson() => _$DeployToJson(this);

  Deploy(this.hash, this.header, this.payment, this.session, this.approvals);
}

@JsonSerializable()
class DeployHeader {
  @JsonKey(name: 'account')
  @PublicKeyJsonConverter()
  PublicKey account;

  @JsonKey(name: 'timestamp')
  @DateTimeJsonConverter()
  DateTime timestamp;

  @JsonKey(name: 'ttl')
  Duration ttl;

  @JsonKey(name: 'gas_price')
  int gasPrice;

  @JsonKey(name: 'body_hash')
  @Cep57ChecksummedHexJsonConverter()
  String bodyHash;

  @JsonKey(name: 'dependencies')
  List<String> dependencies;

  @JsonKey(name: 'chain_name')
  String chainName;

  factory DeployHeader.fromJson(Map<String, dynamic> json) =>
      _$DeployHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$DeployHeaderToJson(this);

  DeployHeader(this.account, this.timestamp, this.ttl, this.gasPrice,
      this.bodyHash, this.dependencies, this.chainName);
}

class TimeToLiveJsonConverter implements JsonConverter<int, String> {
  const TimeToLiveJsonConverter();

  @override
  int fromJson(String json) {
    return int.parse(json);
  }

  @override
  String toJson(int value) {
    return value.toString();
  }
}

class DurationJsonConverter implements JsonConverter<Duration, String> {
  const DurationJsonConverter();

  static String shorten(String input, String long, String short) {
    return input.replaceAll(RegExp("$long(s)?"), short);
  }

  /// Converts from a string in human readable format (e.g. 1h) to [Duration] object.
  @override
  Duration fromJson(String json) {
    // Convert a string that represents time in human readable format,
    // e.g. 1hour 32min, or 2hours 5mins to milliseconds.
    int milliseconds = 0;
    final List<String> parts = json.split(' ');
    for (var part in parts) {
      part = shorten(part, "nsec", "ns");
      part = shorten(part, "usec", "us");
      part = shorten(part, "msec", "ms");
      part = shorten(part, "sec", "s");
      part = shorten(part, "min", "m");
      part = shorten(part, "hrs", "h");
      part = shorten(part, "hour", "h");
      part = shorten(part, "day", "d");
      part = shorten(part, "week", "w");
      part = shorten(part, "month", "M");
      part = shorten(part, "year", "y");
      // Take the numeric part of the string and convert it to milliseconds.
      int i = part.length - 1;
      while (!(part[i].codeUnitAt(0) >= '0'.codeUnitAt(0) &&
          part[i].codeUnitAt(0) <= '9'.codeUnitAt(0))) {
        i--;
      }
      int val = int.parse(part.substring(0, i + 1));
      switch (part[part.length - 1]) {
        case 'y':
          milliseconds += val * 365 * 24 * 60 * 60 * 1000;
          break;
        case 'M':
          milliseconds += val * 30 * 24 * 60 * 60 * 1000;
          break;
        case 'w':
          milliseconds += val * 7 * 24 * 60 * 60 * 1000;
          break;
        case 'd':
          milliseconds += val * 24 * 60 * 60 * 1000;
          break;
        case 'h':
          milliseconds += val * 60 * 60 * 1000;
          break;
        case 'm':
          milliseconds += val * 60 * 1000;
          break;
        case 's':
          milliseconds += val * 1000;
          break;
      }
    }
    return Duration(milliseconds: milliseconds);
  }

  @override
  String toJson(Duration value) {
    // Convert to human readable format.
    // For example, 1h, 20m, 1s
    var copy = Duration(milliseconds: value.inMilliseconds);
    var result = '';
    if (copy.inDays > 0) {
      result += '${copy.inDays}d ';
      copy = copy - Duration(days: copy.inDays);
    }
    if (copy.inHours > 0) {
      result += '${copy.inHours}h ';
      copy = copy - Duration(hours: copy.inHours);
    }
    if (copy.inMinutes > 0) {
      result += '${copy.inMinutes}m ';
      copy = copy - Duration(minutes: copy.inMinutes);
    }
    if (copy.inSeconds > 0) {
      result += '${copy.inSeconds}s ';
      copy = copy - Duration(seconds: copy.inSeconds);
    }
    if (copy.inMilliseconds > 0) {
      result += '${copy.inMilliseconds}ms ';
      copy = copy - Duration(milliseconds: copy.inMilliseconds);
    }
    if (copy.inMicroseconds > 0) {
      result += '${copy.inMicroseconds}us ';
    }
    return result.trim();
  }
}
