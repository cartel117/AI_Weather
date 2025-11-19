# 中央氣象署天氣 API 服務 (Retrofit + Dio)

此專案使用 **Retrofit** 和 **Dio** 提供完整的天氣 API 服務，用於存取中央氣象署開放資料平台。

## 技術架構

- **Retrofit**: 類型安全的 HTTP 客戶端，使用註解定義 API
- **Dio**: 強大的 HTTP 請求庫，支援攔截器和錯誤處理
- **Freezed**: 不可變資料類別生成
- **json_serializable**: JSON 序列化/反序列化

## 檔案結構

```
lib/
├── core/
│   ├── constants/
│   │   └── api_constants.dart          # API 常數配置
│   └── network/
│       └── dio_client.dart             # Dio 客戶端配置
├── data/
│   ├── api/
│   │   ├── weather_api_client.dart     # Retrofit API 客戶端定義
│   │   └── weather_api_client.g.dart   # Retrofit 自動生成
│   ├── models/
│   │   ├── weather_response.dart       # 天氣資料 Model
│   │   ├── weather_response.freezed.dart  # Freezed 自動生成
│   │   └── weather_response.g.dart     # JSON 序列化自動生成
│   └── services/
│       └── weather_api_service.dart    # 天氣 API 服務封裝
└── examples/
    └── retrofit_example.dart           # 使用範例
```

## API 客戶端定義

### WeatherApiClient (Retrofit)

使用 Retrofit 註解定義 API：

```dart
@RestApi(baseUrl: 'https://opendata.cwa.gov.tw/api/v1')
abstract class WeatherApiClient {
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  @GET('/rest/datastore/F-C0032-001')
  Future<WeatherResponse> getWeatherForecast(
    @Query('Authorization') String authorization,
    {@Query('locationName') String? locationName}
  );
}
```

### DioClient 配置

提供預設的 Dio 配置，包含：
- 基礎 URL 設定
- 超時設定
- 日誌攔截器
- 錯誤處理攔截器

```dart
final dio = DioClient.createDio();
final apiClient = WeatherApiClient(dio);
```

## 使用方法

### 快速開始

```dart
import 'package:weather/data/services/weather_api_service.dart';

void main() async {
  // 建立服務實例（使用預設配置）
  final weatherService = WeatherApiService();

  try {
    // 取得臺北市天氣預報
    final forecast = await weatherService.getWeatherForecast(
      locationName: '臺北市',
    );
    
    print('地區數量: ${forecast.records.location.length}');
    
  } on WeatherApiException catch (e) {
    print('API 錯誤: $e');
  }
}
```

### 自訂 Dio 配置

```dart
import 'package:dio/dio.dart';
import 'package:weather/data/api/weather_api_client.dart';
import 'package:weather/data/services/weather_api_service.dart';

void main() async {
  // 自訂 Dio 配置
  final customDio = Dio(
    BaseOptions(
      baseUrl: 'https://opendata.cwa.gov.tw/api/v1',
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
    ),
  );

  // 添加自訂攔截器
  customDio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST: ${options.method} ${options.path}');
        handler.next(options);
      },
    ),
  );

  // 建立 API 客戶端
  final apiClient = WeatherApiClient(customDio);
  final weatherService = WeatherApiService(apiClient: apiClient);

  // 使用服務
  final forecast = await weatherService.getWeatherForecast();
}
```

## API 方法

### 1. getWeatherForecast()
取得一般天氣預報（36小時）

```dart
final forecast = await weatherService.getWeatherForecast(
  locationName: '臺北市', // 可選
);
```

### 2. getWeatherObservation()
取得局屬氣象站觀測資料

```dart
final observation = await weatherService.getWeatherObservation(
  stationId: 'C0A980', // 可選
);
```

### 3. get36HoursForecast()
取得鄉鎮天氣預報（未來2天）

```dart
final forecast = await weatherService.get36HoursForecast(
  locationName: '中正區',
);
```

### 4. getWeeklyForecast()
取得一週天氣預報

```dart
final weekForecast = await weatherService.getWeeklyForecast(
  locationName: '臺北市',
);
```

## 錯誤處理

### 使用 DioException

Retrofit 使用 Dio，所有網路錯誤會被包裝為 `DioException`：

```dart
try {
  final forecast = await weatherService.getWeatherForecast();
} on WeatherApiException catch (e) {
  // 業務邏輯錯誤
  print('錯誤: ${e.message}');
  print('狀態碼: ${e.statusCode}');
} catch (e) {
  // 其他錯誤
  print('未預期的錯誤: $e');
}
```

### 錯誤類型

Service 會自動處理以下錯誤類型：
- `connectionTimeout`: 連線超時
- `sendTimeout`: 請求超時
- `receiveTimeout`: 回應超時
- `badResponse`: HTTP 錯誤回應
- `cancel`: 請求取消
- `unknown`: 未知網路錯誤

## 資料模型

### WeatherResponse

使用 Freezed 定義的不可變資料類別：

```dart
@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    required bool success,
    required Result result,
    required Records records,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
```

### 主要資料結構

- **Records**: 包含 `datasetDescription` 和 `location` 列表
- **Location**: 地點資訊，包含 `locationName` 和 `weatherElement` 列表
- **WeatherElement**: 天氣元素（如溫度、降雨），包含 `elementName` 和 `time` 列表
- **TimeData**: 時間段資料，包含 `startTime`、`endTime` 和 `parameter`
- **Parameter**: 參數值，包含 `parameterName`、`parameterValue`、`parameterUnit`

## 程式碼生成

### 生成所有程式碼

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Watch 模式（自動生成）

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### 清理生成的檔案

```bash
dart run build_runner clean
```

## 依賴套件

```yaml
dependencies:
  dio: ^5.4.0                      # HTTP 客戶端
  retrofit: ^4.0.3                 # 類型安全 API 客戶端
  freezed_annotation: ^2.4.4       # Freezed 註解
  json_annotation: ^4.8.1          # JSON 註解

dev_dependencies:
  build_runner: ^2.4.9             # 程式碼生成工具
  retrofit_generator: ^8.2.1       # Retrofit 程式碼生成器
  freezed: ^2.5.2                  # Freezed 程式碼生成器
  json_serializable: ^6.8.0        # JSON 序列化生成器
```

## Retrofit 優勢

1. **類型安全**: 編譯時檢查 API 定義
2. **程式碼簡潔**: 使用註解定義 API，減少樣板程式碼
3. **自動序列化**: 自動處理 JSON 序列化/反序列化
4. **錯誤處理**: 統一的錯誤處理機制
5. **測試友善**: 容易進行單元測試和模擬

## 執行範例

```bash
dart run lib/examples/retrofit_example.dart
```

## API 文檔

中央氣象署 API 文檔：
https://opendata.cwa.gov.tw/dist/opendata-swagger.html

## 注意事項

1. API 有請求頻率限制，請適度使用
2. API Key 已配置在 `api_constants.dart`
3. 建議在生產環境將 API Key 移至環境變數
4. Dio 攔截器會記錄所有請求/回應，生產環境可考慮關閉詳細日誌
5. 網路請求預設超時為 30 秒
