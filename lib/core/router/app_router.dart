import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../view/pages/weather_page.dart';
import '../../view/pages/city_detail_page.dart';
import '../../view/pages/home_page.dart';
import 'route_names.dart';

/// 應用程式路由配置
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: RouteNames.weather,
        name: RouteNames.weather,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const WeatherPage(),
        ),
      ),
      GoRoute(
        path: '${RouteNames.cityDetail}/:cityName',
        name: RouteNames.cityDetail,
        pageBuilder: (context, state) {
          final cityName = state.pathParameters['cityName'] ?? '';
          return MaterialPage(
            key: state.pageKey,
            child: CityDetailPage(cityName: cityName),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('錯誤')),
      body: Center(
        child: Text('找不到頁面: ${state.uri}'),
      ),
    ),
  );
}
