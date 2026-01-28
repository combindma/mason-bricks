import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageInfoProvider = FutureProvider<PackageInfo>(isAutoDispose: false, (ref) async {
  return await PackageInfo.fromPlatform();
});