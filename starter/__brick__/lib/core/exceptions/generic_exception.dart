import 'package:easy_localization/easy_localization.dart';

import 'base_exception.dart';

class GenericException implements BaseException {
  @override
  String handleError(error, [StackTrace? stackTrace]) {
    return 'errors.unknown'.tr();
  }
}
