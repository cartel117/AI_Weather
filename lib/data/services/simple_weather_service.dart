import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_station.dart';
import '../../core/constants/api_constants.dart';

/// 簡單的天氣服務 (使用 http package)
class SimpleWeatherService {
  http.Client? _client;

  SimpleWeatherService({http.Client? client}) : _client = client;

  /// 獲取或創建 HTTP Client
  http.Client _getClient() {
    _client ??= http.Client();
    return _client!;
  }

  /// 取得氣象站觀測資料
  /// 取得全台灣主要城市的天氣資料
  Future<List<WeatherStation>> fetchWeatherData({
    List<String>? cities,
  }) async {
    final url = '${ApiConstants.apiUrl}${ApiConstants.weatherObservation}?Authorization=${ApiConstants.apiKey}';
    
    try {
      final client = _getClient();
      final response = await client.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final records = data['records'];
        List stations = records['Station'];
        
        // 主要城市列表
        final majorCities = [
          '臺北', '新北', '桃園', '臺中', '臺南', '高雄',
          '基隆', '新竹', '嘉義', '宜蘭', '花蓮', '臺東',
          '澎湖', '金門', '馬祖'
        ];
        
        // 過濾出主要城市的資料
        stations = stations.where((station) {
          final stationName = station['StationName'];
          return majorCities.contains(stationName);
        }).toList();
        
        return stations.map((json) => WeatherStation.fromJson(json)).toList();
      } else {
        throw Exception('無法取得天氣資料: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('載入天氣資料失敗: $e');
    }
  }

  /// 取得所有城市天氣
  Future<List<WeatherStation>> fetchAllCitiesWeather() async {
    return await fetchWeatherData();
  }

  /// 取得高雄市天氣
  Future<WeatherStation?> fetchKaohsiungWeather() async {
    final stations = await fetchWeatherData();
    return stations.firstWhere(
      (station) => station.cityName == '高雄',
      orElse: () => const WeatherStation(cityName: '高雄', weather: '無資料'),
    );
  }

  /// 取得臺北市天氣
  Future<WeatherStation?> fetchTaipeiWeather() async {
    final stations = await fetchWeatherData();
    return stations.firstWhere(
      (station) => station.cityName == '臺北',
      orElse: () => const WeatherStation(cityName: '臺北', weather: '無資料'),
    );
  }

  /// 釋放資源
  void dispose() {
    _client?.close();
    _client = null;
  }
}
