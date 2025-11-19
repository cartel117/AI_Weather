import 'package:weather/data/services/weather_api_service.dart';
import 'package:logger/logger.dart';

final logger = Logger();

/// 使用範例
void main() async {
  // 建立 API Service 實例
  final weatherService = WeatherApiService();

  try {
    // 範例 1: 取得臺北市的天氣預報
    logger.i('正在取得臺北市天氣預報...');
    final forecast = await weatherService.getWeatherForecast(
      locationName: '臺北市',
    );
    logger.i('成功取得資料: ${forecast.records.datasetDescription}');
    
    // 顯示第一個地點的天氣資訊
    if (forecast.records.location.isNotEmpty) {
      final location = forecast.records.location.first;
      logger.i('地點: ${location.locationName}');
      
      for (var element in location.weatherElement) {
        logger.i('天氣元素: ${element.elementName}');
        if (element.time.isNotEmpty) {
          final firstTime = element.time.first;
          logger.i('  時間: ${firstTime.startTime} ~ ${firstTime.endTime}');
          logger.i('  數值: ${firstTime.parameter.parameterName}');
        }
      }
    }

    logger.i('\n---\n');

    // 範例 2: 取得所有地區的天氣預報
    logger.i('正在取得所有地區天氣預報...');
    final allForecast = await weatherService.getWeatherForecast();
    logger.i('總共有 ${allForecast.records.location.length} 個地區');
    
    // 列出所有地區名稱
    for (var location in allForecast.records.location) {
      logger.i('- ${location.locationName}');
    }

    logger.i('\n---\n');

    // 範例 3: 取得36小時鄉鎮預報
    logger.i('正在取得臺北市中正區36小時預報...');
    await weatherService.get36HoursForecast(
      locationName: '中正區',
    );
    logger.i('成功取得36小時預報資料');

  } on WeatherApiException catch (e) {
    logger.e('API 錯誤: $e');
  } catch (e) {
    logger.e('發生錯誤: $e');
  } finally {
    // 記得釋放資源
    // weatherService.dispose();
  }
}
