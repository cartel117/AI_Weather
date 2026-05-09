import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/weather_viewmodel.dart';
import '../viewmodel/weather_state.dart';
import '../data/models/weather_station.dart';
import '../view/widgets/weather/weather_detail_card.dart' show formatTemperature;
import 'my_scaffold.dart';

/// 高雄市天氣顯示頁面
class WeatherView extends ConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherViewModelProvider);
    // 監聽溫度單位，切換時自動重組
    final isCelsius = ref.watch(isCelsiusProvider);

    return MyScaffold(
      appBar: AppBar(
        title: const Text('高雄市天氣'),
        actions: [
          TextButton(
            // 點擊即切換攝氏 / 華氏
            onPressed: () {
              ref.read(isCelsiusProvider.notifier).state = !isCelsius;
            },
            child: Text(
              // 顯示目前單位，提示使用者可點擊切換
              isCelsius ? '°C' : '°F',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage ?? '載入失敗',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(weatherViewModelProvider.notifier).refresh();
                    },
                    child: const Text('重新載入'),
                  ),
                ],
              ),
            );
          }

          if (state.kaohsiungWeather == null) {
            return const Center(
              child: Text('無天氣資料'),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(weatherViewModelProvider.notifier).refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 當前天氣卡片
                  _CurrentWeatherCard(state: state, isCelsius: isCelsius),
                  const SizedBox(height: 24),
                  
                  // 天氣資訊卡片
                  _WeatherInfoCard(state: state, isCelsius: isCelsius),
                  const SizedBox(height: 24),
                  
                  // 其他城市天氣標題
                  const Text(
                    '全台灣天氣',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // 所有城市列表
                  _AllCitiesWeatherList(state: state, isCelsius: isCelsius),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 當前天氣卡片
class _CurrentWeatherCard extends StatelessWidget {
  final WeatherState state;
  // 溫度單位：true = 攝氏，false = 華氏
  final bool isCelsius;

  const _CurrentWeatherCard({required this.state, required this.isCelsius});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: Column(
          children: [
            const Text(
              '高雄市',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            if (state.weatherDescription != null)
              Text(
                state.weatherDescription!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 溫度（根據 isCelsius 轉換單位）
                _WeatherInfoItem(
                  icon: Icons.thermostat,
                  label: '溫度',
                  value: formatTemperature(
                      state.kaohsiungWeather?.temperature, isCelsius),
                ),
                // 濕度
                _WeatherInfoItem(
                  icon: Icons.water_drop,
                  label: '濕度',
                  value: state.humidity ?? '--',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 天氣資訊項目
class _WeatherInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 48,
          color: Colors.white,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

/// 天氣詳細資訊卡片
class _WeatherInfoCard extends StatelessWidget {
  final WeatherState state;
  // 溫度單位：true = 攝氏，false = 華氏
  final bool isCelsius;

  const _WeatherInfoCard({required this.state, required this.isCelsius});

  @override
  Widget build(BuildContext context) {
    final station = state.kaohsiungWeather;
    
    if (station == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '詳細資訊',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _InfoRow(label: '測站名稱', value: station.cityName),
            if (station.temperature != null)
              _InfoRow(label: '氣溫', value: formatTemperature(station.temperature, isCelsius)),
            if (station.humidity != null)
              _InfoRow(label: '相對濕度', value: '${station.humidity}%'),
            if (station.windSpeed != null)
              _InfoRow(label: '風速', value: '${station.windSpeed} m/s'),
            _InfoRow(label: '天氣狀況', value: station.weather),
          ],
        ),
      ),
    );
  }
}

/// 資訊列
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// 全台灣城市天氣列表
class _AllCitiesWeatherList extends StatelessWidget {
  final WeatherState state;
  // 溫度單位：true = 攝氏，false = 華氏
  final bool isCelsius;

  const _AllCitiesWeatherList({required this.state, required this.isCelsius});

  @override
  Widget build(BuildContext context) {
    if (state.allCities.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text('暫無其他城市資料'),
          ),
        ),
      );
    }

    return Column(
      children: state.allCities.map((station) {
        return _CityWeatherCard(station: station, isCelsius: isCelsius);
      }).toList(),
    );
  }
}

/// 單一城市天氣卡片
class _CityWeatherCard extends StatelessWidget {
  final WeatherStation station;
  // 溫度單位：true = 攝氏，false = 華氏
  final bool isCelsius;

  const _CityWeatherCard({required this.station, required this.isCelsius});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _getWeatherGradient(station.weather),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 城市名稱
            Text(
              station.cityName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // 天氣狀況
            Text(
              station.weather,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),
            // 溫度和濕度
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 溫度（根據 isCelsius 轉換單位）
                _WeatherInfoItem(
                  icon: Icons.thermostat,
                  label: '溫度',
                  value: formatTemperature(station.temperature, isCelsius),
                ),
                // 濕度
                _WeatherInfoItem(
                  icon: Icons.water_drop,
                  label: '濕度',
                  value: station.humidity != null 
                      ? '${station.humidity}%' 
                      : '--',
                ),
              ],
            ),
            // 風速（如果有）
            if (station.windSpeed != null) ...[
              const SizedBox(height: 16),
              Center(
                child: _WeatherInfoItem(
                  icon: Icons.air,
                  label: '風速',
                  value: '${station.windSpeed} m/s',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Color> _getWeatherGradient(String weather) {
    if (weather.contains('晴')) {
      return [Colors.orange.shade400, Colors.orange.shade700];
    } else if (weather.contains('雨')) {
      return [Colors.blue.shade400, Colors.blue.shade700];
    } else if (weather.contains('陰')) {
      return [Colors.grey.shade500, Colors.grey.shade800];
    } else if (weather.contains('雲')) {
      return [Colors.blueGrey.shade400, Colors.blueGrey.shade700];
    }
    return [Colors.blue.shade400, Colors.blue.shade700];
  }
}
