import 'package:json_annotation/json_annotation.dart';

// Could be implemented using dart reflection API dart:mirrors, but it has poor support.
// For some reason, @JsonListConverter<Type, JsonType>(creatorFunc) 
// (or @JsonListConverter<Type, JsonType, ConverterType>() for the reflection version) 
// annotation does not work. So it needs to be implemented manually for a type.
class JsonListConverter<T, J> extends JsonConverter<List<T>, List<J>> {
  const JsonListConverter(this._converterFactory);

  final Function _converterFactory;

  @override
  List<T> fromJson(List<J> json) {
    return json.map((e) => (_converterFactory() as JsonConverter<T, J>).fromJson(e)).toList();
  }

  @override
  List<J> toJson(List<T> object) {
    return object.map((e) => (_converterFactory() as JsonConverter<T, J>).toJson(e)).toList();
  }
}