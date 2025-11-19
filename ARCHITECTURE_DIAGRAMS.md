# AI Weather 架構視覺圖

## 整體架構圖

```
┌─────────────────────────────────────────────────────────────────────┐
│                          AI Weather App                              │
│                     (Flutter MVVM Architecture)                      │
└─────────────────────────────────────────────────────────────────────┘
                                  │
                                  │ MaterialApp.router
                                  ▼
┌─────────────────────────────────────────────────────────────────────┐
│                         go_router (AppRouter)                        │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────────────┐    │
│  │ HomePage   │  │WeatherPage │  │  CityDetailPage           │    │
│  │    /       │  │  /weather  │  │  /city-detail/:cityName   │    │
│  └────────────┘  └────────────┘  └────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────┘
                                  │
                ┌─────────────────┼─────────────────┐
                │                 │                 │
                ▼                 ▼                 ▼
┌───────────────────┐  ┌────────────────┐  ┌──────────────────┐
│    HomePage       │  │  WeatherPage   │  │ CityDetailPage   │
├───────────────────┤  ├────────────────┤  ├──────────────────┤
│ - Welcome UI      │  │ BlocProvider   │  │ BlocProvider     │
│ - Navigation      │  │ - Weather VM   │  │ - Weather VM     │
│   Button          │  │ - BlocBuilder  │  │ - BlocBuilder    │
└───────────────────┘  └────────────────┘  └──────────────────┘
                                  │                 │
                                  │ Uses            │
                                  ▼                 ▼
                       ┌──────────────────────────────────┐
                       │  ViewModelFactory (Singleton)    │
                       │  ┌────────────────────────────┐  │
                       │  │ createWeatherViewModel()   │  │
                       │  │   - Manages Dependencies   │  │
                       │  │   - Service Injection      │  │
                       │  └────────────────────────────┘  │
                       └──────────────────────────────────┘
                                      │
                                      │ Creates & Injects
                                      ▼
┌─────────────────────────────────────────────────────────────────────┐
│                         WeatherViewModel (Cubit)                     │
│  ┌────────────────────────────────────────────────────────────┐     │
│  │ State Management Logic                                     │     │
│  │  - loadKaohsiungWeather()                                  │     │
│  │  - refresh()                                               │     │
│  │  - emit(WeatherState)                                      │     │
│  └────────────────────────────────────────────────────────────┘     │
│                              │                                       │
│                              │ Uses                                  │
│                              ▼                                       │
│  ┌────────────────────────────────────────────────────────────┐     │
│  │          SimpleWeatherService (Singleton)                  │     │
│  │  - fetchWeatherData()                                      │     │
│  │  - fetchAllCitiesWeather()                                 │     │
│  └────────────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────────────┘
                                      │
                                      │ Fetches Data
                                      ▼
┌─────────────────────────────────────────────────────────────────────┐
│                      Data Layer (Models & API)                       │
│  ┌──────────────┐  ┌──────────────┐  ┌─────────────────────────┐   │
│  │WeatherStation│  │WeatherResponse│  │ CWB Weather API         │   │
│  │(Freezed)     │  │(Freezed)      │  │ (中央氣象署)              │   │
│  └──────────────┘  └──────────────┘  └─────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

## 數據流向圖

```
User Interaction
       │
       ▼
┌──────────────┐
│  View        │  → 使用者操作 (onPressed, onTap)
│  (Widgets)   │
└──────────────┘
       │
       │ context.read<ViewModel>().method()
       ▼
┌──────────────┐
│  ViewModel   │  → 處理業務邏輯
│  (Cubit)     │
└──────────────┘
       │
       │ service.fetchData()
       ▼
┌──────────────┐
│  Service     │  → API 調用
│              │
└──────────────┘
       │
       │ HTTP Request
       ▼
┌──────────────┐
│  API         │  → 外部數據源
│  (CWB)       │
└──────────────┘
       │
       │ Response (JSON)
       ▼
┌──────────────┐
│  Model       │  → 數據解析
│  (Freezed)   │
└──────────────┘
       │
       │ Return Data
       ▼
┌──────────────┐
│  ViewModel   │  → emit(newState)
│  (Cubit)     │
└──────────────┘
       │
       │ BlocBuilder rebuilds
       ▼
┌──────────────┐
│  View        │  → UI 更新
│  (Widgets)   │
└──────────────┘
       │
       ▼
User sees updated UI
```

## 組件層次結構

```
BaseScaffold (基礎腳手架)
    │
    ├── AppBar
    │
    └── Body
        │
        ├── BlocBuilder<ViewModel, State>
        │   │
        │   ├── LoadingView (載入中)
        │   │   └── CircularProgressIndicator + Text
        │   │
        │   ├── ErrorView (錯誤)
        │   │   └── Icon + Text + RetryButton
        │   │
        │   └── Content (內容)
        │       │
        │       ├── WeatherCard (天氣卡片)
        │       │   ├── City Name
        │       │   ├── Temperature Icon + Value
        │       │   ├── Humidity Info
        │       │   └── Weather Description
        │       │
        │       ├── CityListItem (城市項目)
        │       │   ├── City Icon
        │       │   ├── City Name + Weather
        │       │   ├── Temperature + Humidity
        │       │   └── Chevron Icon
        │       │
        │       └── WeatherDetailCard (詳細卡片)
        │           ├── Main Weather Card
        │           │   ├── City Name
        │           │   ├── Weather Description
        │           │   └── Large Temperature
        │           │
        │           └── Detail Info Card
        │               ├── Humidity
        │               ├── Wind Speed
        │               └── Weather Status
        │
        └── FloatingActionButton (optional)
```

## 狀態流轉圖

```
┌─────────────────────────────────────────────────────────────────┐
│                      WeatherState (Freezed)                      │
└─────────────────────────────────────────────────────────────────┘
                                │
                    ┌───────────┼───────────┐
                    │           │           │
                    ▼           ▼           ▼
        ┌──────────────┐  ┌──────────┐  ┌──────────┐
        │   Loading    │  │  Success │  │  Error   │
        │              │  │          │  │          │
        │ isLoading:   │  │isLoading:│  │isLoading:│
        │   true       │  │  false   │  │  false   │
        │              │  │          │  │          │
        │ data: null   │  │data: []  │  │hasError: │
        │              │  │          │  │  true    │
        └──────────────┘  └──────────┘  └──────────┘
                │               │             │
                │               │             │
                ▼               ▼             ▼
        ┌──────────────┐  ┌──────────┐  ┌──────────┐
        │ LoadingView  │  │  Content │  │ErrorView │
        │              │  │  Widget  │  │          │
        │ - Spinner    │  │  - List  │  │- Message │
        │ - Message    │  │  - Cards │  │- Retry   │
        └──────────────┘  └──────────┘  └──────────┘
```

## 導航流程圖

```
App Start
    │
    ▼
HomePage (/)
    │
    │ "查看天氣" Button
    ▼
WeatherPage (/weather)
    │
    │ Tap City Item
    ▼
CityDetailPage (/city-detail/:cityName)
    │
    │ Back Button / Gesture
    ▼
WeatherPage
    │
    │ Back Button / Gesture
    ▼
HomePage
```

## Factory Pattern 流程圖

```
┌────────────────────────────────────────────────────────┐
│              ViewModelFactory (Static)                  │
│                                                         │
│  ┌──────────────────────────────────────────────┐     │
│  │  Private Static Services (Singleton)         │     │
│  │  - _weatherService: SimpleWeatherService     │     │
│  │  - _otherService: OtherService (future)      │     │
│  └──────────────────────────────────────────────┘     │
│                        │                               │
│                        │ Injects                       │
│                        ▼                               │
│  ┌──────────────────────────────────────────────┐     │
│  │  Public Factory Methods                      │     │
│  │  + createWeatherViewModel()                  │     │
│  │  + createOtherViewModel() (future)           │     │
│  └──────────────────────────────────────────────┘     │
│                        │                               │
│                        │ Returns                       │
│                        ▼                               │
│  ┌──────────────────────────────────────────────┐     │
│  │  ViewModel Instance                          │     │
│  │  WeatherViewModel(service: _weatherService)  │     │
│  └──────────────────────────────────────────────┘     │
└────────────────────────────────────────────────────────┘
                         │
                         │ Used by
                         ▼
┌────────────────────────────────────────────────────────┐
│                  BlocProvider                          │
│  create: (_) => ViewModelFactory                      │
│                  .createWeatherViewModel()             │
│                  ..loadKaohsiungWeather()              │
└────────────────────────────────────────────────────────┘
```

## 可重用組件庫結構

```
lib/view/widgets/
    │
    ├── common/ (通用組件 - 可跨專案使用)
    │   │
    │   ├── BaseScaffold
    │   │   └── 統一的 Scaffold 結構 + PopScope
    │   │
    │   ├── BasePageView
    │   │   └── 三段式頁面佈局 (Top/Main/Bottom)
    │   │
    │   ├── LoadingView
    │   │   └── 統一的載入提示
    │   │
    │   └── ErrorView
    │       └── 統一的錯誤顯示 + 重試
    │
    └── weather/ (業務組件 - 天氣專用)
        │
        ├── WeatherCard
        │   └── 天氣卡片 (可配置高亮)
        │
        ├── CityListItem
        │   └── 城市列表項 (可點擊)
        │
        └── WeatherDetailCard
            └── 詳細天氣資訊卡片
```

## 依賴關係圖

```
┌───────────────────────────────────────────────────────────┐
│                      View Layer                           │
│  HomePage, WeatherPage, CityDetailPage                    │
└───────────────────────────────────────────────────────────┘
                          │
                          │ depends on
                          ▼
┌───────────────────────────────────────────────────────────┐
│                   Widget Components                        │
│  WeatherCard, CityListItem, LoadingView, ErrorView        │
└───────────────────────────────────────────────────────────┘
                          │
                          │ depends on
                          ▼
┌───────────────────────────────────────────────────────────┐
│                  ViewModel Layer                          │
│  WeatherViewModel (Cubit)                                 │
└───────────────────────────────────────────────────────────┘
                          │
                          │ depends on
                          ▼
┌───────────────────────────────────────────────────────────┐
│                   Service Layer                           │
│  SimpleWeatherService                                     │
└───────────────────────────────────────────────────────────┘
                          │
                          │ depends on
                          ▼
┌───────────────────────────────────────────────────────────┐
│                    Model Layer                            │
│  WeatherStation, WeatherResponse (Freezed)                │
└───────────────────────────────────────────────────────────┘
                          │
                          │ depends on
                          ▼
┌───────────────────────────────────────────────────────────┐
│                   External API                            │
│  CWB Weather API (中央氣象署)                              │
└───────────────────────────────────────────────────────────┘

Cross-cutting Concerns:
┌───────────────────────────────────────────────────────────┐
│  Router (go_router) - 路由管理                             │
│  Factory (ViewModelFactory) - 依賴注入                     │
│  Constants (ApiConstants) - 配置管理                       │
└───────────────────────────────────────────────────────────┘
```

## 專案檔案地圖

```
ai_weather/
│
├── 📁 lib/
│   ├── 📄 main.dart (App Entry - 使用 go_router)
│   │
│   ├── 📁 core/ (核心功能)
│   │   ├── 📁 constants/
│   │   │   └── 📄 api_constants.dart
│   │   ├── 📁 factory/
│   │   │   └── 📄 viewmodel_factory.dart ⭐
│   │   ├── 📁 network/
│   │   │   └── 📄 dio_client.dart
│   │   └── 📁 router/
│   │       ├── 📄 app_router.dart ⭐
│   │       └── 📄 route_names.dart ⭐
│   │
│   ├── 📁 data/ (數據層)
│   │   ├── 📁 api/
│   │   │   └── 📄 weather_api_client.dart
│   │   ├── 📁 models/
│   │   │   ├── 📄 weather_station.dart
│   │   │   └── 📄 weather_response.dart
│   │   └── 📁 services/
│   │       └── 📄 simple_weather_service.dart
│   │
│   ├── 📁 view/ (視圖層)
│   │   ├── 📁 pages/ ⭐
│   │   │   ├── 📄 home_page.dart
│   │   │   ├── 📄 weather_page.dart
│   │   │   └── 📄 city_detail_page.dart
│   │   └── 📁 widgets/ ⭐
│   │       ├── 📁 common/
│   │       │   ├── 📄 base_scaffold.dart
│   │       │   ├── 📄 base_page_view.dart
│   │       │   ├── 📄 loading_view.dart
│   │       │   └── 📄 error_view.dart
│   │       └── 📁 weather/
│   │           ├── 📄 weather_card.dart
│   │           ├── 📄 city_list_item.dart
│   │           └── 📄 weather_detail_card.dart
│   │
│   └── 📁 viewmodel/ (視圖模型層)
│       ├── 📄 weather_viewmodel.dart
│       └── 📄 weather_state.dart
│
├── 📁 docs/ (文檔)
│   ├── 📄 ARCHITECTURE.md (450+ 行) ⭐
│   ├── 📄 QUICKSTART.md (550+ 行) ⭐
│   ├── 📄 MIGRATION_GUIDE.md (500+ 行) ⭐
│   └── 📄 REFACTORING_REPORT.md (350+ 行) ⭐
│
├── 📄 README.md (400+ 行) ⭐
├── 📄 pubspec.yaml
└── 📄 analysis_options.yaml

⭐ = 重構新增或大幅更新的檔案
```

## 開發流程圖

```
1. User Request
       │
       ▼
2. Define Route
   (route_names.dart)
       │
       ▼
3. Configure Router
   (app_router.dart)
       │
       ▼
4. Create State Model
   (Freezed)
       │
       ▼
5. Create ViewModel
   (Cubit)
       │
       ▼
6. Register in Factory
   (viewmodel_factory.dart)
       │
       ▼
7. Create Page
   (pages/)
       │
       ▼
8. Create Widgets
   (widgets/)
       │
       ▼
9. Test & Debug
       │
       ▼
10. Done! ✅
```

## 效能優化策略圖

```
┌─────────────────────────────────────────────────────┐
│              Performance Optimization                │
└─────────────────────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┐
        │               │               │
        ▼               ▼               ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│Widget Level │ │ State Level │ │Service Level│
└─────────────┘ └─────────────┘ └─────────────┘
        │               │               │
        ▼               ▼               ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│- const      │ │- buildWhen  │ │- Singleton  │
│  Widget     │ │  condition  │ │  Service    │
│             │ │             │ │             │
│- Key reuse  │ │- Selective  │ │- Cache      │
│             │ │  rebuild    │ │  Strategy   │
│             │ │             │ │             │
│- ListView.  │ │- State      │ │- Connection │
│  builder    │ │  freezed    │ │  Pool       │
└─────────────┘ └─────────────┘ └─────────────┘
```

## 測試策略圖

```
┌─────────────────────────────────────────────────────┐
│                  Testing Strategy                    │
└─────────────────────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┐
        │               │               │
        ▼               ▼               ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│ Unit Tests  │ │Widget Tests │ │Integration  │
│             │ │             │ │   Tests     │
└─────────────┘ └─────────────┘ └─────────────┘
        │               │               │
        ▼               ▼               ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│- ViewModel  │ │- Widget     │ │- End-to-End │
│  Logic      │ │  Rendering  │ │  Flow       │
│             │ │             │ │             │
│- Service    │ │- User       │ │- Navigation │
│  Methods    │ │  Interaction│ │  Flow       │
│             │ │             │ │             │
│- Model      │ │- State      │ │- Data Flow  │
│  Parsing    │ │  Changes    │ │             │
└─────────────┘ └─────────────┘ └─────────────┘
```

---

## 圖例說明

- **┌┐└┘│─**: 邊框和連接線
- **▼**: 向下流動
- **→**: 依賴或流向
- **⭐**: 重要或新增項目
- **📁**: 目錄
- **📄**: 檔案

## 顏色語義 (在支援顏色的 Markdown 檢視器中)

- 🔵 **藍色**: 核心架構組件
- 🟢 **綠色**: 業務邏輯層
- 🟡 **黃色**: 視圖展示層
- 🔴 **紅色**: 外部依賴
- ⚪ **白色**: 配置和工具

---

**文檔版本**: 1.0
**最後更新**: 2025-11-19
**架構類型**: MVVM + Factory Pattern + go_router
