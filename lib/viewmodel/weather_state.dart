import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/weather_station.dart';

part 'weather_state.freezed.dart';

/// 天氣頁面的狀態
@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    WeatherStation? kaohsiungWeather,
    @Default([]) List<WeatherStation> allCities,
    String? currentTemperature,
    String? humidity,
    String? weatherDescription,
    // 最後成功更新的時間，null 表示尚未載入完成
    DateTime? lastUpdatedAt,
  }) = _WeatherState;
}
