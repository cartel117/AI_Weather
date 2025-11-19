import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

/// 中央氣象署 API 回應的主要結構
@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    required bool success,
    required Result result,
    required Records records,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    required String resourceId,
    required List<Field> fields,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);
}

@freezed
class Field with _$Field {
  const factory Field({
    required String id,
    required String type,
  }) = _Field;

  factory Field.fromJson(Map<String, dynamic> json) =>
      _$FieldFromJson(json);
}

@freezed
class Records with _$Records {
  const factory Records({
    required String datasetDescription,
    required List<Location> location,
  }) = _Records;

  factory Records.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    required String locationName,
    required List<WeatherElement> weatherElement,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class WeatherElement with _$WeatherElement {
  const factory WeatherElement({
    required String elementName,
    required List<TimeData> time,
  }) = _WeatherElement;

  factory WeatherElement.fromJson(Map<String, dynamic> json) =>
      _$WeatherElementFromJson(json);
}

@freezed
class TimeData with _$TimeData {
  const factory TimeData({
    required String startTime,
    required String endTime,
    required Parameter parameter,
  }) = _TimeData;

  factory TimeData.fromJson(Map<String, dynamic> json) =>
      _$TimeDataFromJson(json);
}

@freezed
class Parameter with _$Parameter {
  const factory Parameter({
    required String parameterName,
    String? parameterValue,
    String? parameterUnit,
  }) = _Parameter;

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);
}
