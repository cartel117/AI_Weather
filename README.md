# AI Weather - 智慧天氣應用程式

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.3.0+-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.3.0+-0175C2?style=flat&logo=dart)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-green)
![License](https://img.shields.io/badge/License-MIT-blue)

一個採用 **MVVM 架構 + Factory Pattern + go_router** 的現代化 Flutter 天氣應用程式

[功能特色](#功能特色) • [架構設計](#架構設計) • [快速開始](#快速開始) • [文檔](#文檔)

</div>

---

## 📱 功能特色

- ✅ **即時天氣資訊** - 顯示全台灣各地即時天氣數據
- ✅ **城市詳情** - 查看各城市詳細天氣資訊
- ✅ **下拉刷新** - 即時更新天氣資料
- ✅ **美觀 UI** - Material Design 3 設計風格
- ✅ **高效架構** - MVVM + Factory Pattern
- ✅ **模組化設計** - 高度可重用的組件

## 🏗️ 架構設計

本專案採用業界最佳實踐的架構模式：

### 核心架構

```
┌─────────────────────────────────────────────┐
│              View (UI Layer)                │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │  Pages   │  │ Widgets  │  │ Scaffold │  │
│  └──────────┘  └──────────┘  └──────────┘  │
└─────────────────┬───────────────────────────┘
                  │ BlocBuilder
┌─────────────────▼───────────────────────────┐
│          ViewModel (Logic Layer)            │
│  ┌──────────────────────────────────────┐   │
│  │  WeatherViewModel (Cubit)            │   │
│  │  - loadData()                        │   │
│  │  - refresh()                         │   │
│  └──────────────────────────────────────┘   │
└─────────────────┬───────────────────────────┘
                  │ Service Calls
┌─────────────────▼───────────────────────────┐
│            Model (Data Layer)               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │  Models  │  │ Services │  │   API    │  │
│  └──────────┘  └──────────┘  └──────────┘  │
└─────────────────────────────────────────────┘
```

### 設計模式

- **MVVM**: Model-View-ViewModel 分層架構
- **Factory Pattern**: 依賴注入和對象創建管理
- **Repository Pattern**: 數據訪問抽象層
- **BLoC Pattern**: 使用 flutter_bloc 進行狀態管理

### 目錄結構

```
lib/
├── core/                          # 核心功能
│   ├── constants/                 # 常數定義
│   ├── factory/                   # 工廠模式
│   │   └── viewmodel_factory.dart # ViewModel 工廠
│   ├── network/                   # 網路配置
│   └── router/                    # 路由管理
│       ├── app_router.dart        # go_router 配置
│       └── route_names.dart       # 路由名稱
├── data/                          # 數據層
│   ├── api/                       # API 介面
│   ├── models/                    # 數據模型 (Freezed)
│   └── services/                  # 服務層
├── view/                          # 視圖層
│   ├── pages/                     # 頁面
│   └── widgets/                   # 可重用組件
│       ├── common/                # 通用組件
│       └── weather/               # 天氣組件
├── viewmodel/                     # 視圖模型層
│   ├── weather_viewmodel.dart     # ViewModel (Cubit)
│   └── weather_state.dart         # State (Freezed)
└── main.dart                      # 應用入口
```

## 🚀 快速開始

### 環境需求

- Flutter SDK: >=3.3.0
- Dart SDK: >=3.3.0

### 安裝步驟

1. **克隆專案**
```bash
git clone <repository-url>
cd ai_weather
```

2. **安裝依賴**
```bash
flutter pub get
```

3. **生成代碼（Freezed & JSON）**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **配置 API Key**
   
   在 `lib/core/constants/api_constants.dart` 中設置您的 API Key：
   ```dart
   static const String apiKey = 'YOUR_API_KEY';
   ```

5. **運行應用**
```bash
flutter run
```

## 📚 文檔

本專案提供完整的文檔：

| 文檔 | 說明 |
|------|------|
| [ARCHITECTURE.md](./ARCHITECTURE.md) | 完整架構說明和設計模式 |
| [QUICKSTART.md](./QUICKSTART.md) | 快速開始和常用模式 |
| [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) | 從舊架構遷移指南 |
| [WEATHER_API_README.md](./WEATHER_API_README.md) | 天氣 API 使用說明 |
| [RETROFIT_README.md](./RETROFIT_README.md) | Retrofit 配置說明 |

### 核心概念速覽

#### 1️⃣ 使用 go_router 導航

```dart
// 導航到頁面
context.pushNamed(RouteNames.weather);

// 帶參數導航
context.pushNamed(
  RouteNames.cityDetail,
  pathParameters: {'cityName': '台北'},
);
```

#### 2️⃣ 使用 Factory 創建 ViewModel

```dart
BlocProvider(
  create: (_) => ViewModelFactory.createWeatherViewModel(),
  child: YourPage(),
)
```

#### 3️⃣ 使用可重用組件

```dart
// 基礎腳手架
BaseScaffold(
  appBar: AppBar(title: Text('標題')),
  body: YourContent(),
)

// 載入視圖
LoadingView(message: '載入中...')

// 錯誤視圖
ErrorView(
  message: '錯誤訊息',
  onRetry: () => reload(),
)

// 天氣卡片
WeatherCard(
  cityName: '高雄',
  temperature: '28°C',
  humidity: '60%',
  weather: '晴天',
)
```

## 🛠️ 技術棧

### 核心依賴

| 套件 | 版本 | 用途 |
|------|------|------|
| flutter_bloc | ^8.1.6 | 狀態管理 |
| go_router | ^14.3.0 | 路由管理 |
| freezed | ^2.5.2 | 不可變類別生成 |
| dio | ^5.4.0 | HTTP 客戶端 |
| retrofit | ^4.0.3 | REST API 封裝 |

### 開發依賴

- build_runner: 代碼生成
- json_serializable: JSON 序列化
- freezed_annotation: Freezed 註解

完整依賴列表請查看 [pubspec.yaml](./pubspec.yaml)

## 🎯 架構優勢

### 1. 高度可重用
- 組件化設計，View 可大量共用
- 減少重複代碼 50-70%
- 標準化的 Widget 庫

### 2. Factory Pattern
- 集中管理依賴注入
- 服務單例化
- 易於測試和 Mock

### 3. go_router
- 聲明式路由定義
- 支援深層連結
- 類型安全的路由參數

### 4. MVVM 架構
- 清晰的職責分離
- View 與邏輯解耦
- 高可測試性

## 📖 使用範例

### 創建新頁面

```dart
// 1. 定義路由
// lib/core/router/route_names.dart
static const String newPage = '/new-page';

// 2. 配置路由
// lib/core/router/app_router.dart
GoRoute(
  path: RouteNames.newPage,
  name: RouteNames.newPage,
  pageBuilder: (context, state) => MaterialPage(
    child: const NewPage(),
  ),
),

// 3. 創建頁面
// lib/view/pages/new_page.dart
class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text('新頁面')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('返回'),
        ),
      ),
    );
  }
}
```

### 創建帶狀態的頁面

```dart
class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewModelFactory.createYourViewModel()..loadData(),
      child: const _DataPageContent(),
    );
  }
}

class _DataPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text('數據頁面')),
      body: BlocBuilder<YourViewModel, YourState>(
        builder: (context, state) {
          if (state.isLoading) return const LoadingView();
          if (state.hasError) return ErrorView(message: state.errorMessage);
          return YourContent(data: state.data);
        },
      ),
    );
  }
}
```

## 🧪 測試

```bash
# 運行所有測試
flutter test

# 運行特定測試
flutter test test/viewmodel/weather_viewmodel_test.dart

# 生成覆蓋率報告
flutter test --coverage
```

## 🤝 貢獻

歡迎貢獻！請遵循以下步驟：

1. Fork 本專案
2. 創建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 開啟 Pull Request

## 📝 開發指南

- 遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 風格指南
- 使用 `flutter analyze` 檢查代碼
- 使用 `dart format` 格式化代碼
- 為新功能添加測試
- 更新相關文檔

## 📄 授權

本專案採用 MIT 授權 - 詳見 [LICENSE](LICENSE) 文件

## 🙏 致謝

- [Flutter](https://flutter.dev/) - Google 的 UI 框架
- [flutter_bloc](https://bloclibrary.dev/) - 狀態管理解決方案
- [go_router](https://pub.dev/packages/go_router) - 聲明式路由
- [freezed](https://pub.dev/packages/freezed) - 代碼生成工具
- 中央氣象署 - 天氣數據 API

## 📞 聯絡

有問題或建議？歡迎聯繫！

---

<div align="center">

**⭐ 如果這個專案對您有幫助，請給個星星！ ⭐**

Made with ❤️ using Flutter

</div>
