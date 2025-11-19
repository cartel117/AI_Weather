import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../core/constants/api_constants.dart';

final logger = Logger();

/// Dio 客戶端配置
class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.apiUrl,
        connectTimeout: ApiConstants.connectionTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 添加攔截器用於日誌記錄
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => logger.d('[DIO] $obj'),
      ),
    );

    // 添加錯誤處理攔截器
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // 處理不同類型的錯誤
          String errorMessage;
          switch (error.type) {
            case DioExceptionType.connectionTimeout:
              errorMessage = '連線超時';
              break;
            case DioExceptionType.sendTimeout:
              errorMessage = '請求超時';
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage = '回應超時';
              break;
            case DioExceptionType.badResponse:
              errorMessage = 'HTTP ${error.response?.statusCode}: ${error.response?.statusMessage}';
              break;
            case DioExceptionType.cancel:
              errorMessage = '請求已取消';
              break;
            case DioExceptionType.unknown:
              errorMessage = '網路錯誤: ${error.message}';
              break;
            default:
              errorMessage = '未知錯誤';
          }
          
          logger.e('[DIO ERROR] $errorMessage');
          handler.next(error);
        },
      ),
    );

    return dio;
  }
}
