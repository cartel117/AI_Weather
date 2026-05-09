import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/weather_viewmodel.dart';
import '../widgets/common/base_scaffold.dart';
import '../widgets/weather/weather_detail_card.dart';
import '../widgets/common/loading_view.dart';
import '../widgets/common/error_view.dart';

/// 城市詳細天氣頁面
class CityDetailPage extends ConsumerWidget {
  final String cityName;

  const CityDetailPage({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 監聽天氣數據狀態：當 ViewModel 的 state 更新（如載入成功、失敗）時，自動重構此 UI
    final state = ref.watch(weatherViewModelProvider);
    // 2. 監聽溫度單位，切換時自動重組
    final isCelsius = ref.watch(isCelsiusProvider);

    return BaseScaffold(
      appBar: AppBar(
        title: Text('$cityName 天氣詳情'),
        actions: [
          TextButton(
            // 點擊即切換攝氏 / 華氏，共用全域 isCelsiusProvider
            onPressed: () {
              // 注意：事件處理中（副作用）請使用 ref.read，避免不必要的監聽
              ref.read(isCelsiusProvider.notifier).state = !isCelsius;
            },
            child: Text(
              // 顯示目前單位，提示使用者可點擊切換
              isCelsius ? '°C' : '°F',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (state.isLoading) {
            return const LoadingView(message: '載入天氣資料中...');
          }

          if (state.hasError) {
            return ErrorView(
              message: state.errorMessage ?? '載入失敗',
              onRetry: () {
                ref.read(weatherViewModelProvider.notifier).refresh();
              },
            );
          }

          if (state.allCities.isEmpty) {
            return const Center(child: Text('無天氣資料'));
          }

          // 尋找指定城市的資料
          final cityWeather = state.allCities.firstWhere(
            (station) => station.cityName == cityName,
            orElse: () => state.allCities.first,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            // 將溫度單位传達至詳情卡片
            child: WeatherDetailCard(station: cityWeather, isCelsius: isCelsius),
          );
        },
      ),
    );
  }
}
