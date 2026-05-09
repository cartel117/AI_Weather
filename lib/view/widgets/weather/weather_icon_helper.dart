import 'package:flutter/material.dart';

/// 根據天氣描述回傳對應的 icon 和顏色
class WeatherIconHelper {
  WeatherIconHelper._();

  static IconData iconFor(String weather) {
    if (weather.contains('雷')) return Icons.bolt;
    if (weather.contains('雨')) return Icons.umbrella;
    if (weather.contains('雪')) return Icons.ac_unit;
    if (weather.contains('霧')) return Icons.blur_on;
    if (weather.contains('陰')) return Icons.cloud;
    if (weather.contains('雲')) return Icons.cloud_queue;
    if (weather.contains('晴')) return Icons.wb_sunny;
    return Icons.wb_sunny;
  }

  static Color colorFor(String weather) {
    if (weather.contains('雷')) return Colors.purple.shade400;
    if (weather.contains('雨')) return Colors.blue.shade500;
    if (weather.contains('雪')) return Colors.lightBlue.shade300;
    if (weather.contains('霧')) return Colors.grey.shade500;
    if (weather.contains('陰')) return Colors.blueGrey.shade400;
    if (weather.contains('雲')) return Colors.blueGrey.shade300;
    if (weather.contains('晴')) return Colors.orange.shade400;
    return Colors.orange.shade400;
  }
}
