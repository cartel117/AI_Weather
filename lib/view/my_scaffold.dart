import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final bool canPop;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final bool? resizeToAvoidBottomInset;

  /// A custom scaffold that wraps the [PopScope] widget
  ///
  /// which is a custom widget that handles the back button press.
  ///
  /// default value for [canPop] is false (can't pop by pressing back key or swipe guesture)
  ///
  /// about ```canPop``` 如果在該頁面為第一層(stack.len == 1)仍可以透過back key & swipe guesture返回上一頁
  const MyScaffold({
    this.canPop = false,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.drawer,
    this.resizeToAvoidBottomInset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        drawer: drawer,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }
}