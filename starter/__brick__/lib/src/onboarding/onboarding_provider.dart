import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/providers.dart';

final onboardingProvider = AsyncNotifierProvider<OnboardingState, bool>(isAutoDispose: false, OnboardingState.new);

class OnboardingState extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async{
    try {
      await Future.delayed(Duration(seconds: 1));
      final storage = ref.read(storageServiceProvider);
      return await storage.getBool('hasSeenOnboarding')?? false;
    } catch (e, stackTrace) {
      ref.read(globalErrorProvider.notifier).handle(e, stackTrace);
      return false;
    }
  }

  Future<void> completeOnboarding() async {
    final storage = ref.read(storageServiceProvider);
    await storage.save('hasSeenOnboarding', true);
    state = const AsyncData(true);
  }
}