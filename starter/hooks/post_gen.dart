import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) async {
  final dependencies = [
    'hooks_riverpod',
    'flutter_hooks',
    'freezed_annotation',
    'json_annotation',
    'go_router',
    'dio',
    'firebase_core',
    'cloud_firestore',
    'firebase_auth',
    'firebase_remote_config',
    'firebase_crashlytics',
    'firebase_analytics',
    'firebase_messaging',
    'firebase_performance',
    'firebase_app_check',
    'google_sign_in',
    'sign_in_with_apple',
    'package_info_plus',
    'equatable',
    'crypto',
    'easy_localization',
    'flutter_dotenv',
    'shared_preferences',
    'flutter_secure_storage',
    'logger',
    'device_info_plus',
    'url_launcher',
    'force_update_helper',
    'cached_network_image',
    'connectivity_plus',
    'permission_handler',
    'flutter_local_notifications',
    'form_builder_validators',
    'flutter_svg',
    'google_fonts',
    'hugeicons',
    'font_awesome_flutter',
    'introduction_screen',
    'share_plus',
    'shimmer',
    'fluttertoast',
    'infinite_scroll_pagination',
    'country_picker',
  ];
  final devDependencies = [
    'build_runner',
    'freezed',
    'json_serializable',
    'flutter_native_splash',
    'flutter_launcher_icons',
    'mockito',
  ];

  final progress = context.logger.progress('Adding dependencies...');
  final result = await Process.run(
    'flutter',
    ['pub', 'add', ...dependencies],
    runInShell: true,
  );
  if (result.exitCode == 0) {
    progress.complete('Added all dependencies: ${dependencies.join(', ')}');
  } else {
    progress.fail('Failed to add dependencies');
    context.logger.err(result.stderr.toString());
  }

  final progressDev = context.logger.progress('Adding dev_dependencies...');
  final resultDev = await Process.run(
    'flutter',
    ['pub', 'add', '--dev', ...devDependencies],
    runInShell: true,
  );
  if (resultDev.exitCode == 0) {
    progressDev.complete('Added dev_dependencies: ${devDependencies.join(', ')}');
  } else {
    progressDev.fail('Failed to add dev_dependencies');
    context.logger.err(resultDev.stderr.toString());
  }
}
