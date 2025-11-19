# 中央氣象署天氣 API 服務

此專案提供了一個完整的天氣 API 服務，用於存取中央氣象署開放資料平台。

## 檔案結構

```
lib/
├── core/
│   └── constants/
│       └── api_constants.dart          # API 常數配置（包含 API Key）
├── data/
│   ├── models/
│   │   ├── weather_response.dart       # 天氣資料 Model (使用 Freezed)
│   │   ├── weather_response.freezed.dart  # Freezed 自動生成
│   │   └── weather_response.g.dart     # JSON 序列化自動生成
│   └── services/
│       └── weather_api_service.dart    # 天氣 API 服務類別
└── examples/
    └── weather_api_example.dart        # 使用範例
```

## API Key

API Key 已配置在 `lib/core/constants/api_constants.dart`:
```dart
static const String apiKey = 'CWA-A5219274-70A4-4DEB-8698-5F617EF71A12';
```

## 功能

### WeatherApiService 提供以下方法：

1. **getWeatherForecast()** - 取得一般天氣預報（36小時）
2. **getWeatherObservation()** - 取得局屬氣象站觀測資料
3. **get36HoursForecast()** - 取得鄉鎮天氣預報（未來2天）
4. **getWeeklyForecast()** - 取得一週天氣預報

## 使用方法

### 基本使用

```dart
import 'package:weather/data/services/weather_api_service.dart';

void main() async {
  // 建立服務實例
  final weatherService = WeatherApiService();

  try {
    // 取得臺北市天氣預報
    final forecast = await weatherService.getWeatherForecast(
      locationName: '臺北市',
    );
    
    // 處理資料
    print('地區數量: ${forecast.records.location.length}');
    
  } on WeatherApiException catch (e) {
    print('API 錯誤: $e');
  } finally {
    weatherService.dispose();
  }
}
```

### 取得所有地區預報

```dart
final allForecast = await weatherService.getWeatherForecast();

for (var location in allForecast.records.location) {
  print('地區: ${location.locationName}');
}
```

### 取得特定鄉鎮預報

```dart
final townForecast = await weatherService.get36HoursForecast(
  locationName: '中正區',
);
```

## 資料結構

使用 Freezed 和 json_serializable 管理資料模型：

- **WeatherResponse**: API 回應主結構
- **Records**: 記錄資訊
- **Location**: 地點資訊
- **WeatherElement**: 天氣元素（溫度、降雨等）
- **TimeData**: 時間資料
- **Parameter**: 參數值

## 生成 Freezed 檔案

當修改 model 後，執行以下命令生成程式碼：

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

或使用 watch 模式自動生成：

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

## 錯誤處理

服務使用自訂的 `WeatherApiException` 處理錯誤：

```dart
try {
  final forecast = await weatherService.getWeatherForecast();
} on WeatherApiException catch (e) {
  print('錯誤訊息: ${e.message}');
  print('狀態碼: ${e.statusCode}');
}
```

## 依賴套件

- `http`: ^1.1.0 - HTTP 請求
- `freezed_annotation`: ^2.4.4 - Freezed 註解
- `json_annotation`: ^4.8.1 - JSON 註解
- `flutter_bloc`: ^8.1.6 - 狀態管理
- `go_router`: ^14.3.0 - 路由管理

開發依賴：
- `build_runner`: ^2.4.9 - 程式碼生成工具
- `freezed`: ^2.5.2 - 不可變類別生成
- `json_serializable`: ^6.8.0 - JSON 序列化

## 測試範例

執行範例程式：

```bash
flutter run lib/examples/weather_api_example.dart
```

## API 端點

配置在 `ApiConstants`:

- **F-C0032-001**: 一般天氣預報
- **O-A0003-001**: 局屬氣象站觀測資料
- **F-D0047-089**: 鄉鎮天氣預報-未來2天
- **F-D0047-091**: 鄉鎮天氣預報-未來1週

## 注意事項

1. API 有請求頻率限制，請適度使用
2. 記得在使用完畢後呼叫 `dispose()` 釋放資源
3. 建議在實際應用中將 API Key 移到環境變數或安全的配置中
4. 網路請求設有 30 秒超時限制
