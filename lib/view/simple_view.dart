import 'package:flutter/material.dart';
import 'my_scaffold.dart';

/// this class only 3 component
/// appbar is top component
/// middleView is middle component
/// bottomView is bottom component
/// this class is created to reuse View easily
class SimpleView extends StatelessWidget {
  final AppBar? appBar;
  final Widget? topView;
  final Widget? middleView;
  final Widget? bottomView;
  final bool canPop;

  const SimpleView({
    this.appBar,
    this.topView,
    this.middleView,
    this.bottomView,
    this.canPop = true,
    super.key}
  );

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      canPop: canPop,
      appBar: appBar,
      body: Column(
        children: [
          topView ?? Container(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: middleView ?? const SizedBox(height: 32),
            ),
          ),
          bottomView ?? const SizedBox(height: 32),
        ],
      ),
    );
  }
}