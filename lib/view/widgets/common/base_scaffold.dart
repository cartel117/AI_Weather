import 'package:flutter/material.dart';

/// 基礎 Scaffold Widget
/// 提供統一的頁面結構和 PopScope 處理
class BaseScaffold extends StatelessWidget {
  final bool canPop;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;

  const BaseScaffold({
    super.key,
    this.canPop = true,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.drawer,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
