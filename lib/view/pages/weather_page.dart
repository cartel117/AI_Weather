import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/route_names.dart';
import '../../viewmodel/weather_viewmodel.dart';
import '../widgets/common/base_scaffold.dart';
import '../widgets/weather/weather_card.dart';
import '../widgets/weather/city_list_item.dart';
import '../widgets/common/loading_view.dart';
import '../widgets/common/error_view.dart';

/// 天氣頁面
class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherViewModelProvider);

    return BaseScaffold(
      appBar: AppBar(
        title: const Text('全台天氣'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(weatherViewModelProvider.notifier).refresh();
            },
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

          if (state.kaohsiungWeather == null) {
            return const Center(child: Text('無天氣資料'));
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(weatherViewModelProvider.notifier).refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 高雄當前天氣卡片
                  WeatherCard(
                    cityName: state.kaohsiungWeather!.cityName,
                    temperature: state.currentTemperature ?? '--',
                    humidity: state.humidity ?? '--',
                    weather: state.weatherDescription ?? '無資料',
                    isHighlighted: true,
                  ),
                  const SizedBox(height: 24),

                  // 全台天氣標題
                  const Text(
                    '全台灣天氣',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 所有城市列表
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.allCities.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final city = state.allCities[index];
                      return CityListItem(
                        station: city,
                        onTap: () {
                          context.pushNamed(
                            RouteNames.cityDetail,
                            pathParameters: {'cityName': city.cityName},
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
