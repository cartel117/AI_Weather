import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/models/weather_station.dart';
import '../data/services/simple_weather_service.dart';
import 'weather_state.dart';

/// 天氣 ViewModel (使用 Cubit)
class WeatherViewModel extends Cubit<WeatherState> {
  final SimpleWeatherService _weatherService;

  WeatherViewModel({SimpleWeatherService? weatherService})
      : _weatherService = weatherService ?? SimpleWeatherService(),
        super(const WeatherState());

  /// 載入高雄市天氣資料
  Future<void> loadKaohsiungWeather() async {
    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      // 取得所有城市的天氣資料
      final allStations = await _weatherService.fetchAllCitiesWeather();
      
      // 找出高雄的資料
      final kaohsiungStation = allStations.firstWhere(
        (station) => station.cityName == '高雄',
        orElse: () => const WeatherStation(cityName: '高雄', weather: '無資料'),
      );

      emit(state.copyWith(
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
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: '載入天氣資料失敗: $e',
      ));
    }
  }

  /// 重新整理天氣資料
  Future<void> refresh() async {
    await loadKaohsiungWeather();
  }

  @override
  Future<void> close() {
    // 不要在這裡 dispose service，因為它可能被其他 ViewModel 共享
    // Service 的生命週期由 ViewModelFactory 管理
    return super.close();
  }
}
