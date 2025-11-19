# AI Weather 架構文件

## 專案架構概述

本專案採用 **MVVM (Model-View-ViewModel)** 架構模式，結合 **Factory Pattern** 和 **go_router** 路由管理，實現高度可重用和可維護的代碼結構。

## 目錄結構

```
lib/
├── core/                          # 核心功能
│   ├── constants/                 # 常數定義
│   ├── factory/                   # 工廠模式
│   │   └── viewmodel_factory.dart # ViewModel 工廠
│   ├── network/                   # 網路相關
│   └── router/                    # 路由配置
│       ├── app_router.dart        # 路由設定
│       └── route_names.dart       # 路由名稱
├── data/                          # 數據層
│   ├── api/                       # API 介面
│   ├── models/                    # 數據模型
│   └── services/                  # 服務層
├── view/                          # 視圖層
│   ├── pages/                     # 頁面
│   │   ├── home_page.dart         # 首頁
│   │   ├── weather_page.dart      # 天氣頁面
│   │   └── city_detail_page.dart  # 城市詳情頁
│   └── widgets/                   # 可重用組件
│       ├── common/                # 通用組件
│       │   ├── base_scaffold.dart      # 基礎腳手架
│       │   ├── base_page_view.dart     # 基礎頁面視圖
│       │   ├── loading_view.dart       # 載入視圖
│       │   └── error_view.dart         # 錯誤視圖
│       └── weather/               # 天氣相關組件
│           ├── weather_card.dart       # 天氣卡片
│           ├── city_list_item.dart     # 城市列表項
│           └── weather_detail_card.dart # 天氣詳細卡片
├── viewmodel/                     # 視圖模型層
│   ├── weather_viewmodel.dart     # 天氣 ViewModel
│   └── weather_state.dart         # 天氣狀態
└── main.dart                      # 應用程式入口

```

## 架構說明

### 1. MVVM 架構

#### Model (數據層)
- **位置**: `lib/data/models/`
- **職責**: 定義數據結構，處理數據序列化
- **範例**: `WeatherStation`, `WeatherResponse`

#### View (視圖層)
- **位置**: `lib/view/`
- **職責**: 顯示 UI，響應用戶交互
- **特點**: 
  - 使用可重用的 Widget 組件
  - 透過 BlocBuilder 監聽狀態變化
  - 不包含業務邏輯

#### ViewModel (視圖模型層)
- **位置**: `lib/viewmodel/`
- **職責**: 處理業務邏輯，管理狀態
- **實現**: 使用 `flutter_bloc` 的 `Cubit`
- **特點**:
  - 與 View 解耦
  - 可測試性高
  - 狀態管理清晰

### 2. Factory Pattern (工廠模式)

#### ViewModelFactory
```dart
class ViewModelFactory {
  // 單例服務
  static final SimpleWeatherService _weatherService = SimpleWeatherService();
  
  // 創建 ViewModel
  static WeatherViewModel createWeatherViewModel() {
    return WeatherViewModel(weatherService: _weatherService);
  }
}
```

**優點**:
- 集中管理依賴注入
- 方便實現單例模式
- 易於測試和維護
- 解耦對象創建邏輯

### 3. go_router 路由管理

#### 路由配置
```dart
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        pageBuilder: (context, state) => MaterialPage(
          child: const HomePage(),
        ),
      ),
      // 更多路由...
    ],
  );
}
```

**特點**:
- 聲明式路由定義
- 支援深層連結
- 類型安全的路由參數
- 靈活的導航控制

### 4. 可重用 View 組件

#### 設計原則
1. **單一職責**: 每個組件只負責一個功能
2. **組合優於繼承**: 通過組合小組件構建複雜 UI
3. **配置靈活**: 提供豐富的參數配置

#### 常用組件

##### BaseScaffold
基礎腳手架，統一處理 PopScope 和 Scaffold：
```dart
BaseScaffold(
  appBar: AppBar(...),
  body: YourContent(),
  canPop: false,
)
```

##### BasePageView
基礎頁面視圖，提供標準的三段式佈局：
```dart
BasePageView(
  appBar: AppBar(...),
  topSection: TopWidget(),
  mainContent: ContentWidget(),
  bottomSection: BottomWidget(),
)
```

##### WeatherCard
可重用的天氣卡片：
```dart
WeatherCard(
  cityName: '高雄',
  temperature: '28°C',
  humidity: '60%',
  weather: '晴天',
  isHighlighted: true,
)
```

##### LoadingView & ErrorView
通用的載入和錯誤視圖：
```dart
LoadingView(message: '載入中...')
ErrorView(
  message: '載入失敗',
  onRetry: () => refresh(),
)
```

## 使用範例

### 1. 創建新頁面

```dart
class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewModelFactory.createYourViewModel(),
      child: _NewPageContent(),
    );
  }
}

class _NewPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: Text('新頁面')),
      body: BlocBuilder<YourViewModel, YourState>(
        builder: (context, state) {
          if (state.isLoading) return LoadingView();
          if (state.hasError) return ErrorView(...);
          return YourContent(state: state);
        },
      ),
    );
  }
}
```

### 2. 添加新路由

**Step 1**: 在 `route_names.dart` 添加路由名稱
```dart
class RouteNames {
  static const String newPage = '/new-page';
}
```

**Step 2**: 在 `app_router.dart` 添加路由配置
```dart
GoRoute(
  path: RouteNames.newPage,
  name: RouteNames.newPage,
  pageBuilder: (context, state) => MaterialPage(
    child: const NewPage(),
  ),
),
```

**Step 3**: 導航到新頁面
```dart
context.pushNamed(RouteNames.newPage);
```

### 3. 創建 ViewModel

```dart
class YourViewModel extends Cubit<YourState> {
  final YourService _service;

  YourViewModel({YourService? service})
      : _service = service ?? YourService(),
        super(const YourState());

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final data = await _service.fetchData();
      emit(state.copyWith(
        isLoading: false,
        data: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      ));
    }
  }
}
```

### 4. 在 Factory 中註冊

```dart
class ViewModelFactory {
  static final YourService _yourService = YourService();
  
  static YourViewModel createYourViewModel() {
    return YourViewModel(service: _yourService);
  }
}
```

## 狀態管理

使用 `flutter_bloc` 和 `freezed` 進行狀態管理：

```dart
@freezed
class YourState with _$YourState {
  const factory YourState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    YourData? data,
  }) = _YourState;
}
```

## 最佳實踐

### 1. 組件設計
- ✅ 保持組件小而專注
- ✅ 使用 const 構造函數
- ✅ 提供清晰的參數命名
- ✅ 添加文檔註釋

### 2. 狀態管理
- ✅ 使用 Freezed 生成不可變狀態
- ✅ 在 ViewModel 中處理業務邏輯
- ✅ View 只負責 UI 渲染
- ✅ 使用 BlocBuilder 而非 BlocListener（除非需要）

### 3. 路由導航
- ✅ 使用命名路由
- ✅ 集中管理路由名稱
- ✅ 使用類型安全的路由參數
- ✅ 處理路由錯誤

### 4. 依賴注入
- ✅ 使用工廠模式創建對象
- ✅ 服務層使用單例模式
- ✅ 便於單元測試

### 5. 程式碼組織
- ✅ 按功能分層組織檔案
- ✅ 保持目錄結構清晰
- ✅ 使用有意義的命名
- ✅ 避免循環依賴

## 優勢總結

1. **高度可重用**: 組件化設計，View 可大量共用
2. **易於維護**: 清晰的架構分層，職責明確
3. **可測試性**: ViewModel 與 View 解耦，易於單元測試
4. **擴展性強**: Factory Pattern 使添加新功能變得簡單
5. **導航靈活**: go_router 提供強大的路由管理
6. **類型安全**: 使用 Freezed 確保狀態不可變和類型安全

## 相關文件

- [Flutter Bloc 文檔](https://bloclibrary.dev/)
- [go_router 文檔](https://pub.dev/packages/go_router)
- [Freezed 文檔](https://pub.dev/packages/freezed)
- [MVVM 架構模式](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)
