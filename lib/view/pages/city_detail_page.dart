import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/factory/viewmodel_factory.dart';
import '../../viewmodel/weather_viewmodel.dart';
import '../../viewmodel/weather_state.dart';
import '../widgets/common/base_scaffold.dart';
import '../widgets/weather/weather_detail_card.dart';
import '../widgets/common/loading_view.dart';
import '../widgets/common/error_view.dart';

/// 城市詳細天氣頁面
class CityDetailPage extends StatelessWidget {
  final String cityName;

  const CityDetailPage({
    super.key,
    required this.cityName,
  });

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
      appBar: AppBar(
        title: Text('$cityName 天氣詳情'),
      ),
      body: BlocBuilder<WeatherViewModel, WeatherState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingView(message: '載入天氣資料中...');
          }

          if (state.hasError) {
            return ErrorView(
              message: state.errorMessage ?? '載入失敗',
              onRetry: () {
                context.read<WeatherViewModel>().refresh();
              },
            );
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
