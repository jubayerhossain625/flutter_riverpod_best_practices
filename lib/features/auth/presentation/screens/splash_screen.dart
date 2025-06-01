import 'package:flutter/material.dart';
import 'package:flutter_riverpod_best_practices/core/constants/asset_const.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AssetConst.splashBG, fit: BoxFit.fill),
          ),
          Center(child: Image.asset(AssetConst.appLogo)),
        ],
      ),
    );
  }
}
