import '../../viewmodel/weather_viewmodel.dart';
import '../../data/services/simple_weather_service.dart';

/// ViewModel 工廠類別
/// 使用 Factory Pattern 來建立 ViewModel 實例
/// 方便管理依賴注入和單例模式
class ViewModelFactory {
  ViewModelFactory._();

  // 服務單例 - 使用延遲初始化避免 Client 被過早關閉
  static SimpleWeatherService? _weatherService;

  /// 獲取或創建天氣服務實例
  static SimpleWeatherService _getWeatherService() {
    _weatherService ??= SimpleWeatherService();
    return _weatherService!;
  }

  /// 建立 WeatherViewModel
  static WeatherViewModel createWeatherViewModel() {
    return WeatherViewModel(weatherService: _getWeatherService());
  }

  /// 清理資源
  static void dispose() {
    _weatherService?.dispose();
    _weatherService = null;
  }
}
