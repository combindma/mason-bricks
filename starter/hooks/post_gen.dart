import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) async {
  final progressProd = context.logger.progress('Installing production packages');
  await Process.run('flutter', ['pub', 'add' , 'hooks_riverpod', 'flutter_hooks', 'freezed_annotation', 'json_annotation', 'go_router', 'dio', 'equatable', 'firebase_core', 'firebase_auth', 'firebase_remote_config', 'firebase_crashlytics', 'firebase_analytics', 'firebase_messaging', 'intl', 'flutter_dotenv', 'shared_preferences', 'flutter_secure_storage', 'flutter_native_splash', 'logger', 'device_info_plus', 'url_launcher', 'force_update_helper', 'cached_network_image', 'form_builder_validators', 'flutter_svg', 'introduction_screen', 'share_plus', 'shimmer', 'infinite_scroll_pagination']);
  progressProd.complete();

  final progressDev = context.logger.progress('Installing dev packages');
  await Process.run('flutter', ['pub', 'add' , '--dev','flutter_lints', 'riverpod_lint', 'build_runner', 'freezed', 'json_serializable', 'flutter_launcher_icons']);
  progressDev.complete();
}
