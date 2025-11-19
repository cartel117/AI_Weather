# 快速開始指南

## 專案概述

本專案採用 **MVVM + Factory Pattern + go_router** 架構，實現高度模組化和可重用的天氣應用程式。

## 目錄結構速覽

```
lib/
├── core/                   # 核心功能
│   ├── factory/           # 工廠模式
│   └── router/            # 路由配置
├── data/                  # 數據層
│   ├── models/           # 數據模型
│   └── services/         # 服務層
├── view/                  # 視圖層
│   ├── pages/            # 頁面
│   └── widgets/          # 可重用組件
├── viewmodel/             # 視圖模型層
└── main.dart             # 應用入口
```

## 運行專案

### 1. 安裝依賴
```bash
flutter pub get
```

### 2. 生成代碼（如果需要）
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. 運行應用
```bash
flutter run
```

## 核心概念

### 1. 路由導航

#### 導航到頁面
```dart
import 'package:go_router/go_router.dart';
import '../../core/router/route_names.dart';

// 簡單導航
context.pushNamed(RouteNames.weather);

// 帶參數導航
context.pushNamed(
  RouteNames.cityDetail,
  pathParameters: {'cityName': '台北'},
);

// 返回上一頁
context.pop();
```

#### 添加新路由
```dart
// 1. 在 route_names.dart 定義路由名稱
static const String yourPage = '/your-page';

// 2. 在 app_router.dart 配置路由
GoRoute(
  path: RouteNames.yourPage,
  name: RouteNames.yourPage,
  pageBuilder: (context, state) => MaterialPage(
    child: const YourPage(),
  ),
),
```

### 2. 使用 ViewModel

#### 創建 ViewModel
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'your_state.dart';
import '../data/services/your_service.dart';

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

#### 在頁面中使用
```dart
class YourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewModelFactory.createYourViewModel()..loadData(),
      child: const _YourPageContent(),
    );
  }
}

class _YourPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text('您的頁面')),
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

### 3. 使用可重用組件

#### BaseScaffold - 基礎腳手架
```dart
BaseScaffold(
  appBar: AppBar(title: const Text('標題')),
  body: YourContent(),
  floatingActionButton: FloatingActionButton(...),
  canPop: false, // 控制是否可以返回
)
```

#### BasePageView - 三段式頁面佈局
```dart
BasePageView(
  appBar: AppBar(title: const Text('標題')),
  topSection: TopWidget(),      // 頂部區域
  mainContent: ContentWidget(), // 主要內容（可滾動）
  bottomSection: BottomWidget(), // 底部區域
  scrollable: true,              // 主要內容是否可滾動
)
```

#### LoadingView - 載入視圖
```dart
const LoadingView(message: '載入中...')
```

#### ErrorView - 錯誤視圖
```dart
ErrorView(
  message: '載入失敗，請稍後再試',
  onRetry: () {
    // 重試邏輯
    context.read<YourViewModel>().loadData();
  },
)
```

#### WeatherCard - 天氣卡片
```dart
WeatherCard(
  cityName: '高雄',
  temperature: '28°C',
  humidity: '60%',
  weather: '晴天',
  isHighlighted: true, // 是否高亮顯示
)
```

#### CityListItem - 城市列表項
```dart
CityListItem(
  station: weatherStation,
  onTap: () {
    context.pushNamed(
      RouteNames.cityDetail,
      pathParameters: {'cityName': weatherStation.cityName},
    );
  },
)
```

### 4. Factory Pattern

#### 使用 Factory 創建 ViewModel
```dart
// 在頁面中
BlocProvider(
  create: (_) => ViewModelFactory.createWeatherViewModel(),
  child: YourContent(),
)
```

#### 在 Factory 中註冊新服務
```dart
class ViewModelFactory {
  // 服務單例
  static final YourService _yourService = YourService();
  
  // 創建方法
  static YourViewModel createYourViewModel() {
    return YourViewModel(service: _yourService);
  }
}
```

## 常用模式

### 模式 1: 創建簡單頁面
```dart
class SimplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(title: const Text('簡單頁面')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hello World'),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 模式 2: 創建帶狀態管理的頁面
```dart
class StatefulPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewModelFactory.createYourViewModel()..loadData(),
      child: const _StatefulPageContent(),
    );
  }
}

class _StatefulPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        title: const Text('帶狀態的頁面'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<YourViewModel>().loadData(),
          ),
        ],
      ),
      body: BlocBuilder<YourViewModel, YourState>(
        builder: (context, state) {
          if (state.isLoading) return const LoadingView();
          if (state.hasError) return ErrorView(message: state.errorMessage);
          return _buildContent(state);
        },
      ),
    );
  }
  
  Widget _buildContent(YourState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 您的內容
        ],
      ),
    );
  }
}
```

### 模式 3: 創建列表頁面
```dart
ListView.separated(
  itemCount: items.length,
  separatorBuilder: (_, __) => const SizedBox(height: 12),
  itemBuilder: (context, index) {
    final item = items[index];
    return YourListItem(
      item: item,
      onTap: () => _handleItemTap(context, item),
    );
  },
)
```

### 模式 4: 創建下拉刷新頁面
```dart
RefreshIndicator(
  onRefresh: () => context.read<YourViewModel>().refresh(),
  child: SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    child: YourContent(),
  ),
)
```

## 開發流程

### 添加新功能的標準流程

#### 1. 定義數據模型
```dart
// lib/data/models/your_model.dart
@freezed
class YourModel with _$YourModel {
  const factory YourModel({
    required String id,
    required String name,
  }) = _YourModel;
  
  factory YourModel.fromJson(Map<String, dynamic> json) =>
      _$YourModelFromJson(json);
}
```

#### 2. 創建服務層
```dart
// lib/data/services/your_service.dart
class YourService {
  Future<List<YourModel>> fetchData() async {
    // API 調用邏輯
  }
}
```

#### 3. 定義狀態
```dart
// lib/viewmodel/your_state.dart
@freezed
class YourState with _$YourState {
  const factory YourState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    List<YourModel>? data,
  }) = _YourState;
}
```

#### 4. 創建 ViewModel
```dart
// lib/viewmodel/your_viewmodel.dart
class YourViewModel extends Cubit<YourState> {
  final YourService _service;
  
  YourViewModel({YourService? service})
      : _service = service ?? YourService(),
        super(const YourState());
  
  Future<void> loadData() async {
    // 實現邏輯
  }
}
```

#### 5. 註冊到 Factory
```dart
// lib/core/factory/viewmodel_factory.dart
static YourViewModel createYourViewModel() {
  return YourViewModel(service: _yourService);
}
```

#### 6. 添加路由
```dart
// lib/core/router/route_names.dart
static const String yourPage = '/your-page';

// lib/core/router/app_router.dart
GoRoute(
  path: RouteNames.yourPage,
  name: RouteNames.yourPage,
  pageBuilder: (context, state) => MaterialPage(
    child: const YourPage(),
  ),
),
```

#### 7. 創建頁面
```dart
// lib/view/pages/your_page.dart
class YourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewModelFactory.createYourViewModel()..loadData(),
      child: const _YourPageContent(),
    );
  }
}
```

#### 8. 創建可重用組件（如需要）
```dart
// lib/view/widgets/your_widget.dart
class YourWidget extends StatelessWidget {
  final YourModel data;
  final VoidCallback? onTap;
  
  const YourWidget({
    required this.data,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data.name),
        onTap: onTap,
      ),
    );
  }
}
```

## 調試技巧

### 1. 檢查路由
```dart
// 在 app_router.dart 添加 observer
GoRouter(
  observers: [NavigatorObserver()],
  // ...
)
```

### 2. 檢查狀態變化
```dart
class YourViewModel extends Cubit<YourState> {
  @override
  void emit(YourState state) {
    print('State changed: $state');
    super.emit(state);
  }
}
```

### 3. 使用 BlocObserver
```dart
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}

// 在 main.dart
void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
```

## 常見問題

### Q: 如何在不同頁面間傳遞數據？
A: 使用路由參數
```dart
// 傳遞
context.pushNamed(
  RouteNames.detail,
  pathParameters: {'id': '123'},
);

// 接收
final id = state.pathParameters['id'];
```

### Q: 如何處理導航後的回調？
A: 使用 async/await
```dart
final result = await context.pushNamed(RouteNames.detail);
if (result != null) {
  // 處理返回結果
}
```

### Q: 如何共享 ViewModel？
A: 在父層級提供 BlocProvider
```dart
BlocProvider(
  create: (_) => ViewModelFactory.createYourViewModel(),
  child: YourAppContent(), // 子頁面可以訪問
)
```

## 效能最佳化

### 1. 使用 const 構造函數
```dart
const YourWidget(key: key)  // ✅ 好
YourWidget(key: key)         // ❌ 避免
```

### 2. 拆分 BlocBuilder
```dart
// ✅ 只重建需要的部分
BlocBuilder<YourViewModel, YourState>(
  buildWhen: (prev, curr) => prev.data != curr.data,
  builder: (context, state) => DataWidget(data: state.data),
)
```

### 3. 使用 ListView.builder
```dart
// ✅ 延遲加載
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)

// ❌ 一次性加載所有
ListView(
  children: items.map((item) => ItemWidget(item)).toList(),
)
```

## 測試

### 單元測試 ViewModel
```dart
void main() {
  group('YourViewModel', () {
    late YourViewModel viewModel;
    late MockYourService mockService;

    setUp(() {
      mockService = MockYourService();
      viewModel = YourViewModel(service: mockService);
    });

    test('loadData success', () async {
      when(mockService.fetchData()).thenAnswer(
        (_) async => [YourModel(id: '1', name: 'Test')],
      );

      await viewModel.loadData();

      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.data?.length, 1);
    });
  });
}
```

### Widget 測試
```dart
void main() {
  testWidgets('YourPage displays data', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => MockYourViewModel(),
          child: const YourPage(),
        ),
      ),
    );

    expect(find.text('Expected Text'), findsOneWidget);
  });
}
```

## 相關文檔

- [ARCHITECTURE.md](./ARCHITECTURE.md) - 完整架構文檔
- [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) - 遷移指南
- [README.md](./README.md) - 專案說明

## 獲取幫助

遇到問題？請參考：
1. 架構文檔 (ARCHITECTURE.md)
2. 遷移指南 (MIGRATION_GUIDE.md)
3. 範例代碼 (lib/view/pages/)
4. Flutter Bloc 文檔
5. go_router 文檔

---

**祝您開發順利！** 🚀
