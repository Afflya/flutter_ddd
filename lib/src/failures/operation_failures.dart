import 'common_interfaces.dart';

abstract class OperationFailure implements Failure {}

class CommonActionFailure with OperationFailure {
  const CommonActionFailure();

  const factory CommonActionFailure.missingArgument([String? argName]) =
      _MissingArgument;

  const factory CommonActionFailure.serverError([Object? error]) = _ServerError;
}

class _MissingArgument extends CommonActionFailure {
  final String? argName;

  const _MissingArgument([this.argName]);
}

class _ServerError extends CommonActionFailure {
  final Object? error;

  const _ServerError([this.error]);
}
