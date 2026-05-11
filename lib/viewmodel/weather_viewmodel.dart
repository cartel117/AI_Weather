import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/data/models/weather_station.dart';
import '../data/services/simple_weather_service.dart';
import 'weather_state.dart';

/// 全域 Provider
final weatherViewModelProvider =
    StateNotifierProvider<WeatherViewModel, WeatherState>((ref) {
  return WeatherViewModel();
});

/// 溫度單位 Provider（true = 攝氏°C, false = 華氏°F）
/// 全域共享，切換後所有頁面同步更新
final isCelsiusProvider = StateProvider<bool>((ref) => true);

/// 天氣 ViewModel (使用 Riverpod StateNotifier)
class WeatherViewModel extends StateNotifier<WeatherState> {
  final SimpleWeatherService _weatherService;

  WeatherViewModel({SimpleWeatherService? weatherService})
      : _weatherService = weatherService ?? SimpleWeatherService(),
        super(const WeatherState()) {
    loadAllCitiesWeather();
  }

  /// 載入高雄市天氣資料
  Future<void> loadAllCitiesWeather() async {
    state = state.copyWith(isLoading: true, hasError: false);

    try {
      // 取得所有城市的天氣資料
      final allStations = await _weatherService.fetchAllCitiesWeather();

      // 找出高雄的資料
      final kaohsiungStation = allStations.firstWhere(
        (station) => station.cityName == '高雄',
        orElse: () => const WeatherStation(cityName: '高雄', weather: '無資料'),
      );

      state = state.copyWith(
        isLoading: false,
        allCities: allStations,
        kaohsiungWeather: kaohsiungStation,
        currentTemperature: kaohsiungStation.temperature != null
            ? '${kaohsiungStation.temperature}°C'
            : '--',
        humidity: kaohsiungStation.humidity != null
            ? '${kaohsiungStation.humidity}%'
            : '--',
        weatherDescription: kaohsiungStation.weather,
        // 記錄本次成功載入的時間
        lastUpdatedAt: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: '載入天氣資料失敗: $e',
      );
    }
  }

  /// 重新整理天氣資料
  Future<void> refresh() async {
    await loadAllCitiesWeather();
  }
}
