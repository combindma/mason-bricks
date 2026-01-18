import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../bootstrap/providers.dart';

class OnboardingController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async{
    final storage = ref.read(storageServiceProvider);
    return await storage.getBool('hasOnboardingInitialized')?? false;
  }

  Future<void> completeOnboarding() async {
    final storage = ref.read(storageServiceProvider);
    await storage.save('hasOnboardingInitialized', true);
    state = const AsyncData(true);
  }
}

final onboardingControllerProvider = AsyncNotifierProvider<OnboardingController, bool>(isAutoDispose: true, OnboardingController.new);