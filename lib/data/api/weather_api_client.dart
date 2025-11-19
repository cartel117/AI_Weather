import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/weather_response.dart';

part 'weather_api_client.g.dart';

/// 使用 Retrofit 的中央氣象署天氣 API 客戶端
@RestApi(baseUrl: 'https://opendata.cwa.gov.tw/api/v1')
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  /// 取得一般天氣預報 (36小時)
  /// [authorization] API Key
  /// [locationName] 可選的地區名稱，例如：臺北市、新北市等
  @GET('/rest/datastore/F-C0032-001')
  Future<WeatherResponse> getWeatherForecast(
    @Query('Authorization') String authorization, {
    @Query('locationName') String? locationName,
  });

  /// 取得局屬氣象站觀測資料
  /// [authorization] API Key
  /// [stationId] 可選的氣象站 ID
  @GET('/rest/datastore/O-A0003-001')
  Future<WeatherResponse> getWeatherObservation(
    @Query('Authorization') String authorization, {
    @Query('StationId') String? stationId,
  });

  /// 取得鄉鎮天氣預報 (未來2天)
  /// [authorization] API Key
  /// [locationName] 鄉鎮名稱
  @GET('/rest/datastore/F-D0047-089')
  Future<WeatherResponse> get36HoursForecast(
    @Query('Authorization') String authorization, {
    @Query('locationName') String? locationName,
  });

  /// 取得一週天氣預報
  /// [authorization] API Key
  /// [locationName] 鄉鎮名稱
  @GET('/rest/datastore/F-D0047-091')
  Future<WeatherResponse> getWeeklyForecast(
    @Query('Authorization') String authorization, {
    @Query('locationName') String? locationName,
  });
}
