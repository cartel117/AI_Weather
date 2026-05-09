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
    final state = ref.watch(weatherViewModelProvider);

    return BaseScaffold(
      appBar: AppBar(
        title: Text('$cityName 天氣詳情'),
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
            child: WeatherDetailCard(station: cityWeather),
          );
        },
      ),
    );
  }
}
