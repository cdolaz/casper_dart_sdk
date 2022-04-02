import 'package:json_annotation/json_annotation.dart';

// Could be implemented using dart reflection API dart:mirrors, but it has poor support.
// For some reason, @JsonListConverter<Type>(creatorFunc) 
// (or @JsonListConverter<Type, ConverterType>() for the reflection version) 
// annotation does not work. So it needs to be implemented manually for a type.
// `<Type, dynamic>` type params are used instead of `<Type, JsonType>` as a workaround for `json_serializable`'s
// `list as List<String>` (or else) cast failing in an empty list.
class JsonListConverter<T> extends JsonConverter<List<T>, List<dynamic>> {
  const JsonListConverter(this._converterFactory);

  final Function _converterFactory;

  @override
  List<T> fromJson(List<dynamic> json) {
    return json.map((e) => (_converterFactory() as JsonConverter<T, dynamic>).fromJson(e)).toList();
  }

  @override
  List<dynamic> toJson(List<T> object) {
    return object.map((e) => (_converterFactory() as JsonConverter<T, dynamic>).toJson(e)).toList();
  }
}