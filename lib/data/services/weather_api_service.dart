import 'package:dio/dio.dart';
import '../api/weather_api_client.dart';
import '../models/weather_response.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';

/// 中央氣象署天氣 API Service (使用 Retrofit)
class WeatherApiService {
  final WeatherApiClient _apiClient;

  WeatherApiService({WeatherApiClient? apiClient})
      : _apiClient = apiClient ?? WeatherApiClient(DioClient.createDio());

  /// 取得一般天氣預報 (36小時)
  /// [locationName] 可選的地區名稱，例如：臺北市、新北市等
  Future<WeatherResponse> getWeatherForecast({String? locationName}) async {
    try {
      return await _apiClient.getWeatherForecast(
        ApiConstants.apiKey,
        locationName: locationName,
      );
    } on DioException catch (e) {
      throw WeatherApiException(
        _handleDioError(e),
        e.response?.statusCode,
      );
    } catch (e) {
      throw WeatherApiException('未知錯誤: $e', null);
    }
  }

  /// 取得局屬氣象站觀測資料
  Future<WeatherResponse> getWeatherObservation({String? stationId}) async {
    try {
      return await _apiClient.getWeatherObservation(
        ApiConstants.apiKey,
        stationId: stationId,
      );
    } on DioException catch (e) {
      throw WeatherApiException(
        _handleDioError(e),
        e.response?.statusCode,
      );
    } catch (e) {
      throw WeatherApiException('未知錯誤: $e', null);
    }
  }

  /// 取得鄉鎮天氣預報 (未來2天)
  /// [locationName] 鄉鎮名稱
  Future<WeatherResponse> get36HoursForecast({String? locationName}) async {
    try {
      return await _apiClient.get36HoursForecast(
        ApiConstants.apiKey,
        locationName: locationName,
      );
    } on DioException catch (e) {
      throw WeatherApiException(
        _handleDioError(e),
        e.response?.statusCode,
      );
    } catch (e) {
      throw WeatherApiException('未知錯誤: $e', null);
    }
  }

  /// 取得一週天氣預報
  /// [locationName] 鄉鎮名稱
  Future<WeatherResponse> getWeeklyForecast({String? locationName}) async {
    try {
      return await _apiClient.getWeeklyForecast(
        ApiConstants.apiKey,
        locationName: locationName,
      );
    } on DioException catch (e) {
      throw WeatherApiException(
        _handleDioError(e),
        e.response?.statusCode,
      );
    } catch (e) {
      throw WeatherApiException('未知錯誤: $e', null);
    }
  }

  /// 處理 Dio 錯誤
  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return '連線超時';
      case DioExceptionType.sendTimeout:
        return '請求超時';
      case DioExceptionType.receiveTimeout:
        return '回應超時';
      case DioExceptionType.badResponse:
        return 'HTTP ${error.response?.statusCode}: ${error.response?.statusMessage}';
      case DioExceptionType.cancel:
        return '請求已取消';
      case DioExceptionType.unknown:
        return '網路錯誤: ${error.message}';
      default:
        return '未知錯誤';
    }
  }
}

/// 天氣 API 例外處理
class WeatherApiException implements Exception {
  final String message;
  final int? statusCode;

  WeatherApiException(this.message, this.statusCode);

  @override
  String toString() => 'WeatherApiException: $message (Status: $statusCode)';
}
