import 'package:flutter/material.dart';

/// 天氣卡片 Widget
/// 可重複使用的天氣顯示卡片
class WeatherCard extends StatelessWidget {
  final String cityName;
  final String temperature;
  final String humidity;
  final String weather;
  final bool isHighlighted;

  const WeatherCard({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.weather,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isHighlighted ? 8 : 4,
      color: isHighlighted ? Colors.blue.shade50 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isHighlighted
            ? BorderSide(color: Colors.blue.shade300, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cityName,
                  style: TextStyle(
                    fontSize: isHighlighted ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isHighlighted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '當前位置',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.thermostat,
                  size: 32,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  temperature,
                  style: TextStyle(
                    fontSize: isHighlighted ? 48 : 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _InfoRow(
              icon: Icons.water_drop,
              label: '濕度',
              value: humidity,
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.cloud,
              label: '天氣',
              value: weather,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
