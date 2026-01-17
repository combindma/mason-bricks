import 'base_exception.dart';

class GenericException implements BaseException {
  @override
  String handleError(error, [StackTrace? stackTrace]) {
    return 'An unexpected error occurred. Please try again.';
  }
}
