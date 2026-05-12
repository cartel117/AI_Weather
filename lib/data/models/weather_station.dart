import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_station.freezed.dart';
part 'weather_station.g.dart';

/// 氣象站資料模型
@freezed
class WeatherStation with _$WeatherStation {
  const factory WeatherStation({
    required String cityName,
    required String weather,
    String? temperature,
    String? humidity,
    String? windSpeed,
    // 氣象站緯度（GeoInfo.Coordinates）
    double? latitude,
    // 氣象站經度（GeoInfo.Coordinates）
    double? longitude,
  }) = _WeatherStation;

  factory WeatherStation.fromJson(Map<String, dynamic> json) {
    // CWA API 的座標陣列：index 0 = TWD97，index 1 = WGS84
    final coords = json['GeoInfo']?['Coordinates'] as List?;
    final wgs84 = coords != null && coords.length > 1 ? coords[1] : null;

    return WeatherStation(
      cityName: json['StationName'] ?? '',
      weather: json['WeatherElement']?['Weather'] ?? '--',
      temperature: json['WeatherElement']?['AirTemperature']?.toString(),
      humidity: json['WeatherElement']?['RelativeHumidity']?.toString(),
      windSpeed: json['WeatherElement']?['WindSpeed']?.toString(),
      latitude: double.tryParse(wgs84?['StationLatitude']?.toString() ?? ''),
      longitude: double.tryParse(wgs84?['StationLongitude']?.toString() ?? ''),
    );
  }
}

/// 氣象站 API 回應
@freezed
class WeatherStationResponse with _$WeatherStationResponse {
  const factory WeatherStationResponse({
    required bool success,
    required Records records,
  }) = _WeatherStationResponse;

  factory WeatherStationResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherStationResponseFromJson(json);
}

@freezed
class Records with _$Records {
  const factory Records({
    required List<Map<String, dynamic>> station,
  }) = _Records;

  factory Records.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);
}
