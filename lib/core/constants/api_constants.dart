class ApiConstants {
  // 中央氣象署 API Key
  // 建議使用環境變數或在本地配置，避免將真實 API Key 上傳到 GitHub
  // 使用方式：flutter run --dart-define=CWB_API_KEY=your_actual_key
  static const String apiKey = String.fromEnvironment(
    'CWB_API_KEY',
    defaultValue: 'YOUR_CWB_API_KEY_HERE', // 請替換為您的 API Key
  );
  
  // API Base URL
  static const String baseUrl = 'https://opendata.cwa.gov.tw/api';
  
  // API Version
  static const String apiVersion = 'v1';
  
  // 完整的 API URL
  static String get apiUrl => '$baseUrl/$apiVersion';
  
  // 常用的 API Endpoints
  static const String weatherForecast = '/rest/datastore/F-C0032-001'; // 一般天氣預報
  static const String weatherObservation = '/rest/datastore/O-A0003-001'; // 局屬氣象站觀測資料
  static const String weatherStation36H = '/rest/datastore/F-D0047-089'; // 鄉鎮天氣預報-臺灣未來2天天氣預報
  static const String weatherWeek = '/rest/datastore/F-D0047-091'; // 鄉鎮天氣預報-臺灣未來1週天氣預報
  
  // Timeout 設定
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
