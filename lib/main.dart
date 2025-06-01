import 'package:flutter/material.dart';
import 'package:flutter_riverpod_best_practices/di/service_locator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'my_app.dart'; // Import the app configuration

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(ProviderScope(child: const MyApp()));
  //configLoading();
}

// class CustomAnimation extends EasyLoadingAnimation {
//   CustomAnimation();

//   @override
//   Widget buildWidget(
//     Widget child,
//     AnimationController controller,
//     AlignmentGeometry alignment,
//   ) {
//     return Opacity(
//       opacity: controller.value,
//       child: RotationTransition(turns: controller, child: child),
//     );
//   }
// }

// void configLoading() {
//   EasyLoading.instance
//     ..indicatorType = EasyLoadingIndicatorType.fadingCube
//     ..loadingStyle =
//         EasyLoadingStyle
//             .custom // Custom style to set specific colors
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = Colors.white
//     ..backgroundColor =
//         Colors
//             .lightGreenAccent
//             .shade700 // Light green background
//     ..indicatorColor =
//         Colors
//             .white // White indicator
//     ..textColor = Colors.black
//     ..maskColor = Colors.black.withOpacity(0.5)
//     ..userInteractions = false
//     ..dismissOnTap = false;
// }
