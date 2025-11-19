# 架構遷移指南

## 從舊架構到新 MVVM 架構

本文檔說明如何將專案從原始架構遷移到新的 MVVM + Factory Pattern + go_router 架構。

## 主要變更

### 1. 路由系統

#### 之前（MaterialApp）
```dart
MaterialApp(
  home: const WeatherView(),
)
```

#### 之後（go_router）
```dart
MaterialApp.router(
  routerConfig: AppRouter.router,
)
```

**優勢**:
- 支援深層連結
- 聲明式路由管理
- 更好的導航控制
- 路由參數類型安全

### 2. ViewModel 創建

#### 之前（直接創建）
```dart
BlocProvider(
  create: (context) => WeatherViewModel()..loadKaohsiungWeather(),
  child: const _WeatherViewContent(),
)
```

#### 之後（Factory Pattern）
```dart
BlocProvider(
  create: (_) => ViewModelFactory.createWeatherViewModel()..loadKaohsiungWeather(),
  child: const _WeatherPageContent(),
)
```

**優勢**:
- 集中管理依賴
- 便於測試和 Mock
- 服務單例管理
- 解耦對象創建

### 3. View 組件化

#### 之前（單一大型 Widget）
```dart
class WeatherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherViewModel()..loadKaohsiungWeather(),
      child: MyScaffold(
        appBar: AppBar(...),
        body: BlocBuilder<WeatherViewModel, WeatherState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // 大量內聯 UI 代碼...
          },
        ),
      ),
    );
  }
}
```

#### 之後（組件化設計）
```dart
// 頁面層
class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewModelFactory.createWeatherViewModel()..loadKaohsiungWeather(),
      child: const _WeatherPageContent(),
    );
  }
}

// 內容層
class _WeatherPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(...),
      body: BlocBuilder<WeatherViewModel, WeatherState>(
        builder: (context, state) {
          if (state.isLoading) return const LoadingView();
          if (state.hasError) return ErrorView(...);
          return _buildContent(state);
        },
      ),
    );
  }
  
  Widget _buildContent(WeatherState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WeatherCard(...),  // 可重用組件
          CityListItem(...), // 可重用組件
        ],
      ),
    );
  }
}
```

**優勢**:
- 組件可重用
- 代碼更清晰
- 易於維護
- 便於測試

### 4. Scaffold 使用

#### 之前（MyScaffold）
```dart
MyScaffold(
  canPop: false,
  appBar: AppBar(...),
  body: YourContent(),
)
```

#### 之後（BaseScaffold）
```dart
BaseScaffold(
  canPop: false,
  appBar: AppBar(...),
  body: YourContent(),
  bottomNavigationBar: BottomBar(), // 新增支援
)
```

**改進**:
- 支援更多 Scaffold 屬性
- 更清晰的命名
- 統一的結構

## 遷移步驟

### Step 1: 添加核心架構檔案

1. 創建 `lib/core/router/` 目錄
2. 創建 `lib/core/factory/` 目錄
3. 添加路由配置文件
4. 添加工廠類別文件

### Step 2: 重構 View

1. 將頁面移到 `lib/view/pages/`
2. 將可重用組件移到 `lib/view/widgets/`
3. 使用 BaseScaffold 替換 MyScaffold
4. 提取重複的 UI 組件

### Step 3: 更新 main.dart

```dart
// 替換 MaterialApp 為 MaterialApp.router
MaterialApp.router(
  routerConfig: AppRouter.router,
)
```

### Step 4: 使用 Factory Pattern

```dart
// 在 ViewModelFactory 中註冊服務
static final YourService _service = YourService();

static YourViewModel createYourViewModel() {
  return YourViewModel(service: _service);
}
```

### Step 5: 測試

1. 測試所有路由導航
2. 測試狀態管理
3. 測試組件重用
4. 驗證依賴注入

## 對比範例

### 創建新功能：顯示城市詳情

#### 舊架構實現
```dart
// 1. 創建完整頁面 (約 200 行代碼)
class CityDetailView extends StatelessWidget {
  final String cityName;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherViewModel()..loadKaohsiungWeather(),
      child: MyScaffold(
        appBar: AppBar(title: Text(cityName)),
        body: BlocBuilder<WeatherViewModel, WeatherState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            // 內聯大量 UI 代碼
            return Column(
              children: [
                // 溫度卡片 (內聯 50 行)
                Card(
                  child: Column(
                    children: [
                      Text(cityName),
                      Text('${temperature}°C'),
                      // 更多內聯代碼...
                    ],
                  ),
                ),
                // 濕度卡片 (內聯 30 行)
                // 更多重複代碼...
              ],
            );
          },
        ),
      ),
    );
  }
}

// 2. 手動添加導航
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => CityDetailView(cityName: cityName),
  ),
);
```

#### 新架構實現
```dart
// 1. 在 route_names.dart 添加路由名稱 (1 行)
static const String cityDetail = '/city-detail';

// 2. 在 app_router.dart 配置路由 (10 行)
GoRoute(
  path: '${RouteNames.cityDetail}/:cityName',
  name: RouteNames.cityDetail,
  pageBuilder: (context, state) {
    final cityName = state.pathParameters['cityName'] ?? '';
    return MaterialPage(
      child: CityDetailPage(cityName: cityName),
    );
  },
),

// 3. 創建簡潔頁面 (約 50 行，使用可重用組件)
class CityDetailPage extends StatelessWidget {
  final String cityName;

  const CityDetailPage({required this.cityName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewModelFactory.createWeatherViewModel()..loadKaohsiungWeather(),
      child: _CityDetailPageContent(cityName: cityName),
    );
  }
}

class _CityDetailPageContent extends StatelessWidget {
  final String cityName;

  const _CityDetailPageContent({required this.cityName});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: Text('$cityName 天氣詳情')),
      body: BlocBuilder<WeatherViewModel, WeatherState>(
        builder: (context, state) {
          if (state.isLoading) return const LoadingView();
          if (state.hasError) return ErrorView(...);
          
          final cityWeather = state.allCities.firstWhere(...);
          
          // 使用可重用組件，代碼簡潔
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: WeatherDetailCard(station: cityWeather),
          );
        },
      ),
    );
  }
}

// 4. 類型安全的導航 (1 行)
context.pushNamed(
  RouteNames.cityDetail,
  pathParameters: {'cityName': cityName},
);
```

**對比總結**:
- 舊架構：~200 行代碼，重複性高
- 新架構：~60 行代碼，組件可重用
- 代碼減少：70%
- 可維護性：大幅提升

## 架構對比表

| 特性 | 舊架構 | 新架構 |
|------|--------|--------|
| 路由管理 | MaterialApp + Navigator | go_router（聲明式） |
| 依賴注入 | 直接創建 | Factory Pattern |
| View 重用 | 低（複製貼上） | 高（組件化） |
| 代碼行數 | 多 | 少（減少 50-70%） |
| 可測試性 | 中 | 高 |
| 維護難度 | 高 | 低 |
| 擴展性 | 中 | 高 |
| 類型安全 | 中 | 高（路由參數） |
| 深層連結 | 不支援 | 支援 |
| 狀態管理 | 分散 | 集中 |

## 核心優勢

### 1. 大量共用 View
- 可重用組件庫（WeatherCard, CityListItem, LoadingView 等）
- 標準化的頁面結構（BaseScaffold, BasePageView）
- 減少重複代碼 50-70%

### 2. Factory Pattern 優勢
- 集中管理依賴注入
- 服務單例化
- 易於測試和 Mock
- 解耦對象創建邏輯

### 3. go_router 優勢
- 聲明式路由定義
- 支援深層連結
- 類型安全的路由參數
- 更好的導航控制

### 4. MVVM 優勢
- 清晰的職責分離
- View 與業務邏輯解耦
- 高可測試性
- 易於維護和擴展

## 最佳實踐建議

### DO ✅
- 使用 Factory 創建 ViewModel
- 使用命名路由進行導航
- 提取可重用的 Widget 組件
- 保持 View 簡潔，只負責 UI
- 在 ViewModel 中處理業務邏輯
- 使用 Freezed 管理狀態

### DON'T ❌
- 不要在 View 中直接創建 ViewModel
- 不要使用 Navigator.push（使用 context.pushNamed）
- 不要重複內聯 UI 代碼（提取為組件）
- 不要在 View 中處理業務邏輯
- 不要硬編碼路由字串
- 不要跳過 Factory 直接創建服務

## 常見問題

### Q: 如何添加新頁面？
A: 
1. 在 `route_names.dart` 添加路由名稱
2. 在 `app_router.dart` 配置路由
3. 創建頁面檔案在 `lib/view/pages/`
4. 使用 `context.pushNamed()` 導航

### Q: 如何創建可重用組件？
A:
1. 在 `lib/view/widgets/` 創建組件
2. 提供清晰的參數介面
3. 使用 const 構造函數
4. 添加文檔註釋

### Q: 如何管理依賴？
A:
1. 在 `ViewModelFactory` 創建服務單例
2. 通過 Factory 方法注入依賴
3. 便於測試時替換 Mock

### Q: 舊代碼需要全部重寫嗎？
A: 不需要。可以逐步遷移：
1. 先更新 main.dart 使用 go_router
2. 逐個頁面重構
3. 提取可重用組件
4. 最後統一使用 Factory

## 參考資源

- [ARCHITECTURE.md](./ARCHITECTURE.md) - 完整架構文檔
- [Flutter Bloc](https://bloclibrary.dev/)
- [go_router](https://pub.dev/packages/go_router)
- [Factory Pattern](https://refactoring.guru/design-patterns/factory-method)
