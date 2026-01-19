import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) async {
  final dependencies = [
    'flutter_localizations',
    'hooks_riverpod',
    'flutter_hooks',
    'freezed_annotation',
    'json_annotation',
    'go_router',
    'dio',
    'equatable',
    'firebase_core',
    'firebase_auth',
    'firebase_remote_config',
    'firebase_crashlytics',
    'firebase_analytics',
    'firebase_messaging',
    'intl',
    'flutter_dotenv',
    'shared_preferences',
    'flutter_secure_storage',
    'flutter_native_splash',
    'logger',
    'device_info_plus',
    'url_launcher',
    'force_update_helper',
    'cached_network_image',
    'form_builder_validators',
    'flutter_svg',
    'introduction_screen',
    'share_plus',
    'shimmer',
    'infinite_scroll_pagination',
  ];
  final devDependencies = [
    'riverpod_lint',
    'mockito',
    'build_runner',
    'freezed',
    'json_serializable',
    'flutter_launcher_icons',
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
