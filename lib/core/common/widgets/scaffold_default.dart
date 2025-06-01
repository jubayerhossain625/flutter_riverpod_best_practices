import 'package:flutter/material.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/appbar_default.dart';

class ScaffoldDefault extends StatelessWidget {
  final AppBarDefault? appBar;
  final FloatingActionButton? floatingActionButton;
  final Widget body;

  const ScaffoldDefault({
    super.key,
    this.appBar,
    this.floatingActionButton,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 0), child: body),
    );
  }
}
