import 'value_failures.dart';

sealed class CollectionValueFailure<T> implements ValueFailure<T> {
  const CollectionValueFailure();

  const factory CollectionValueFailure.collectionTooLong({
    required T failedValue,
    required int max,
  }) = _CollectionTooLong<T>;

  const factory CollectionValueFailure.unacceptableLength({
    required T failedValue,
    required int min,
    required int max,
  }) = _UnacceptableLength<T>;

  const factory CollectionValueFailure.missingValue({
    required T failedValue,
    required dynamic expectedValue,
  }) = _MissingValue<T>;

  const factory CollectionValueFailure.hasDuplicates({
    required T failedValue,
  }) = _HasDuplicates<T>;

  const factory CollectionValueFailure.notSorted({
    required T failedValue,
  }) = _ListNotSorted<T>;

  const factory CollectionValueFailure.incompatibleValues({
    required T failedValue,
  }) = _IncompatibleValues<T>;

  const factory CollectionValueFailure.empty({
    required T failedValue,
  }) = _Empty<T>;

  const factory CollectionValueFailure.containsValueOutOfRange({
    required T failedValue,
    required num min,
    required num max,
  }) = _ContainsValueOutOfRange<T>;
}

class _CollectionTooLong<T> extends CollectionValueFailure<T> {
  @override
  final T failedValue;
  final int max;

  const _CollectionTooLong({
    required this.failedValue,
    required this.max,
  });
}

class _UnacceptableLength<T> extends CollectionValueFailure<T> {
  @override
  final T failedValue;
  final int min;
  final int max;

  const _UnacceptableLength({
    required this.failedValue,
    required this.min,
    required this.max,
  });
}

class _MissingValue<T> extends CollectionValueFailure<T> {
  @override
  final T failedValue;
  final dynamic expectedValue;

  const _MissingValue({
    required this.failedValue,
    required this.expectedValue,
  });
}

class _HasDuplicates<T> extends CollectionValueFailure<T> {
  @override
  final T failedValue;

  const _HasDuplicates({
    required this.failedValue,
  });
}

class _ListNotSorted<T> extends CollectionValueFailure<T> {
  @override
  final T failedValue;

  const _ListNotSorted({
    required this.failedValue,
  });
}

class _IncompatibleValues<T> extends CollectionValueFailure<T> {
  @override
  final T failedValue;

  const _IncompatibleValues({
    required this.failedValue,
  });
}

class _Empty<T> extends CollectionValueFailure<T> {
  @override
  final T failedValue;

  const _Empty({
    required this.failedValue,
  });
}

class _ContainsValueOutOfRange<T> extends CollectionValueFailure<T> {
  @override
  final T failedValue;
  final num min;
  final num max;

  const _ContainsValueOutOfRange({
    required this.failedValue,
    required this.min,
    required this.max,
  });
}
