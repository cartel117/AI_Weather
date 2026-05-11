import 'package:flutter/material.dart';
import '../../../data/models/weather_station.dart';
import 'weather_icon_helper.dart';

/// 溫度格式化工具函式
/// [celsius] 攝氏字串（來自 API），[isCelsius] true = 顯示°C，false = 轉換並顯示°F
String formatTemperature(String? celsius, bool isCelsius) {
  if (celsius == null) return '--';
  if (isCelsius) return '$celsius°C';
  final c = double.tryParse(celsius);
  if (c == null) return '--';
  final f = (c * 9 / 5 + 32).toStringAsFixed(1);
  return '$f°F';
}

/// 天氣詳細資訊卡片 Widget
/// 顯示完整的天氣資訊
class WeatherDetailCard extends StatelessWidget {
  final WeatherStation station;
  // 溫度單位：true = 攝氏，false = 華氏
  final bool isCelsius;

  const WeatherDetailCard({
    super.key,
    required this.station,
    this.isCelsius = true,
  });

  @override
  Widget build(BuildContext context) {
    // 根據溫度計算漸層顏色：高溫暖色、低溫冷色
    final gradient = _temperatureGradient(station.temperature);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 主要天氣卡片（溫度漸層背景）
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(gradient: gradient),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // 城市名稱
                Text(
                  station.cityName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // 天氣 icon
                Icon(
                  WeatherIconHelper.iconFor(station.weather),
                  size: 80,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(height: 8),

                // 天氣描述
                Text(
                  station.weather,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 24),

                // 溫度顯示
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.thermostat,
                      size: 64,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      formatTemperature(station.temperature, isCelsius),
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 詳細資訊列表
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '詳細資訊',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _DetailItem(
                  icon: Icons.water_drop,
                  label: '濕度',
                  value: station.humidity != null 
                      ? '${station.humidity}%' 
                      : '--',
                ),
                const Divider(),
                _DetailItem(
                  icon: Icons.air,
                  label: '風速',
                  value: station.windSpeed != null 
                      ? '${station.windSpeed} m/s' 
                      : '--',
                ),
                const Divider(),
                _DetailItem(
                  icon: Icons.cloud,
                  label: '天氣狀況',
                  value: station.weather,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 根據攝氏溫度返回對應漸層：
  /// ≥ 30°C 紅橙暖色，20–29°C 橙黃，10–19°C 藍綠，< 10°C 藍紫冷色
  LinearGradient _temperatureGradient(String? celsius) {
    final temp = double.tryParse(celsius ?? '');
    if (temp == null) {
      return const LinearGradient(
        colors: [Color(0xFF78909C), Color(0xFF546E7A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    if (temp >= 30) {
      return const LinearGradient(
        colors: [Color(0xFFFF6F00), Color(0xFFE53935)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (temp >= 20) {
      return const LinearGradient(
        colors: [Color(0xFFFFB300), Color(0xFFFB8C00)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (temp >= 10) {
      return const LinearGradient(
        colors: [Color(0xFF26C6DA), Color(0xFF00897B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFF5C6BC0), Color(0xFF3949AB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
            color: Colors.blue,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
