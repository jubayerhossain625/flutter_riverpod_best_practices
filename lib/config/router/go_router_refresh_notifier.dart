import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [ChangeNotifier] that listens to a Riverpod [StateNotifier]
/// and tells GoRouter to refresh when the state changes.
// class GoRouterRefreshNotifier extends ChangeNotifier {
//   late final ProviderSubscription _subscription;

//   GoRouterRefreshNotifier(StateNotifierProvider provider, Ref ref) {
//     _subscription = ref.listen(
//       provider,
//       (_, __) => notifyListeners(),
//     );
//   }

//   @override
//   void dispose() {
//     _subscription.close();
//     super.dispose();
//   }
// }

class GoRouterRefreshNotifier<T> extends ChangeNotifier {
  late final ProviderSubscription<T> _subscription;

  GoRouterRefreshNotifier(StateNotifierProvider<StateNotifier<T>, T> provider, Ref ref) {
    _subscription = ref.listen<T>(
      provider,
      (_, __) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

