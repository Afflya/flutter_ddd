import 'failures/value_failures.dart';

class NotAuthenticatedError extends Error {}

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}

class NullValueOptionError extends Error {}

class UnsupportedTypeError extends Error {
  final Object? object;

  UnsupportedTypeError([this.object]);
}

class EitherIsLeftError extends Error {}

class EitherIsRightError extends Error {}

class EmptyCollectionError extends Error {}

class TypeNotInCaseError extends Error {
  final Type type;

  TypeNotInCaseError(this.type);

  @override
  String toString() => 'Function not specified for type $type';
}