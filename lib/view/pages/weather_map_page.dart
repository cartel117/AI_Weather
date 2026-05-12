import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../data/models/weather_station.dart';
import '../../viewmodel/weather_viewmodel.dart';
import '../widgets/common/base_scaffold.dart';
import '../widgets/common/error_view.dart';
import '../widgets/common/loading_view.dart';
import '../widgets/weather/weather_icon_helper.dart';
import '../widgets/weather/weather_detail_card.dart' show formatTemperature;

/// 氣象站地圖頁面
/// 使用 flutter_map + OpenStreetMap tiles 顯示全台各測站分布
class WeatherMapPage extends ConsumerWidget {
  const WeatherMapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherViewModelProvider);
    final isCelsius = ref.watch(isCelsiusProvider);

    return BaseScaffold(
      appBar: AppBar(
        title: const Text('天氣地圖'),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(isCelsiusProvider.notifier).state = !isCelsius;
            },
            child: Text(
              isCelsius ? '°C' : '°F',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(weatherViewModelProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (state.isLoading) {
          return const LoadingView(message: '載入天氣資料中...');
        }
        if (state.hasError) {
          return ErrorView(
            message: state.errorMessage ?? '載入失敗',
            onRetry: () => ref.read(weatherViewModelProvider.notifier).refresh(),
          );
        }
        if (state.allCities.isEmpty) {
          return const Center(child: Text('無天氣資料'));
        }

        // 只保留有座標的站點
        final stations = state.allCities
            .where((s) => s.latitude != null && s.longitude != null)
            .toList();

        return FlutterMap(
          options: const MapOptions(
            // 以台灣中心為初始視角
            initialCenter: LatLng(23.9, 121.0),
            initialZoom: 7.5,
            minZoom: 6,
            maxZoom: 14,
          ),
          children: [
            // OpenStreetMap 底圖
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.weather',
            ),
            // 各氣象站 Marker 層
            MarkerLayer(
              markers: stations
                  .map((s) => _buildMarker(context, s, isCelsius))
                  .toList(),
            ),
          ],
        );
      }),
    );
  }

  Marker _buildMarker(
      BuildContext context, WeatherStation station, bool isCelsius) {
    final color = WeatherIconHelper.colorFor(station.weather);
    final icon = WeatherIconHelper.iconFor(station.weather);
    final temp = formatTemperature(station.temperature, isCelsius);

    return Marker(
      point: LatLng(station.latitude!, station.longitude!),
      width: 56,
      height: 72,
      child: GestureDetector(
        onTap: () => _showStationPopup(context, station, isCelsius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 圓形圖示背景
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            // 溫度標籤
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 2,
                  )
                ],
              ),
              child: Text(
                temp,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 點擊 Marker 後顯示測站詳細資訊
  void _showStationPopup(
      BuildContext context, WeatherStation station, bool isCelsius) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  WeatherIconHelper.iconFor(station.weather),
                  color: WeatherIconHelper.colorFor(station.weather),
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  station.cityName,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _PopupRow(label: '天氣', value: station.weather),
            _PopupRow(
              label: '溫度',
              value: formatTemperature(station.temperature, isCelsius),
            ),
            if (station.humidity != null)
              _PopupRow(label: '濕度', value: '${station.humidity}%'),
            if (station.windSpeed != null)
              _PopupRow(label: '風速', value: '${station.windSpeed} m/s'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _PopupRow extends StatelessWidget {
  final String label;
  final String value;

  const _PopupRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(label,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
          ),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }
}
