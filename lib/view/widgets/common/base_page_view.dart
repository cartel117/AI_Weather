import 'package:flutter/material.dart';

/// 基礎頁面 Widget - 提供統一的頁面結構
/// 
/// 這個 Widget 設計用於大量共用 View，採用組合模式
/// 可以靈活組合不同的區塊來構建頁面
/// 
/// 使用範例:
/// ```dart
/// BasePageView(
///   appBar: AppBar(title: Text('標題')),
///   topSection: TopWidget(),
///   mainContent: ContentWidget(),
///   bottomSection: BottomWidget(),
/// )
/// ```
class BasePageView extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? topSection;
  final Widget? mainContent;
  final Widget? bottomSection;
  final Widget? floatingActionButton;
  final bool canPop;
  final EdgeInsets? padding;
  final bool scrollable;

  const BasePageView({
    super.key,
    this.appBar,
    this.topSection,
    this.mainContent,
    this.bottomSection,
    this.floatingActionButton,
    this.canPop = true,
    this.padding,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        if (topSection != null) topSection!,
        Expanded(
          child: scrollable
              ? SingleChildScrollView(
                  padding: padding ?? const EdgeInsets.all(16),
                  child: mainContent ?? const SizedBox(),
                )
              : Padding(
                  padding: padding ?? const EdgeInsets.all(16),
                  child: mainContent ?? const SizedBox(),
                ),
        ),
        if (bottomSection != null) bottomSection!,
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: content,
      floatingActionButton: floatingActionButton,
    );
  }
}
