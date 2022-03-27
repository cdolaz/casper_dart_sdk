import 'package:json_annotation/json_annotation.dart';

/// Returns true if all chars in a string are uppercase or lowercase.
/// Returns false if the string is mixed case or if there are no alphabetic chars.
bool isHexStringSameCase(String hex) {
  int m = 0;
  for (int i = 0; i < hex.length; i++) {
    int c = hex.codeUnitAt(i);
    if (c >= 'A'.codeUnitAt(0) && c <= 'F'.codeUnitAt(0)) {
      m |= 1;
    } else if (c >= 'a'.codeUnitAt(0) && c <= 'f'.codeUnitAt(0)) {
      m |= 2;
    } else if (c >= '0'.codeUnitAt(0) && c <= '9'.codeUnitAt(0)) {
      m |= 0;
    } else {
      throw ArgumentError("Invalid hexadecimal string: $hex");
    }
  }
  return m != 3;
}

int hexStringToInt(String hexString) {
  return int.parse(hexString, radix: 16);
}

String dateTimeToString(DateTime dateTime) {
  return dateTime.toIso8601String();
}

String capitalizeFirstLetter(String string) {
  return string[0].toUpperCase() + string.substring(1);
}

class DateTimeJsonConverter implements JsonConverter<DateTime, String> {
  const DateTimeJsonConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String();
  }
}


class HumanReadableDurationJsonConverter implements JsonConverter<Duration, String> {
  const HumanReadableDurationJsonConverter();

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
