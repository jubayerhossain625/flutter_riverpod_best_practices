import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/config/app_theme.dart';
import 'config/router/app_router.dart';
import 'core/constants/app_const.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(
      goRouterProvider,
    ); // Get the router from provider
    //final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    if (globalStatusBarHeight == 0.0) {
      globalStatusBarHeight = MediaQuery.of(context).viewPadding.top;
    }
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Riverpod Best Practices',
      theme: AppTheme.themeData,
      routerConfig: goRouter,
    );
  }
}
