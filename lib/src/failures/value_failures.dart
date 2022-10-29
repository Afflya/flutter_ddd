import 'common_interfaces.dart';

abstract class ValueFailure<T> implements Failure {
  T get failedValue;
}

abstract class CommonValueFailure<T> with ValueFailure<T> {
  const CommonValueFailure();

  const factory CommonValueFailure.invalidValue({
    required T failedValue,
  }) = _InvalidValue<T>;

  const factory CommonValueFailure.insufficientLength({
    required T failedValue,
    required num min,
  }) = _InsufficientLength<T>;

  const factory CommonValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = _ExceedingLength<T>;

  const factory CommonValueFailure.invalidLength({
    required T failedValue,
    required num requiredLength,
  }) = _InvalidLength<T>;

  const factory CommonValueFailure.empty({
    required T failedValue,
  }) = _Empty<T>;

  const factory CommonValueFailure.multiline({
    required T failedValue,
  }) = _Multiline<T>;

  const factory CommonValueFailure.numberTooLarge({
    required T failedValue,
    required num max,
  }) = _NumberTooLarge<T>;

  const factory CommonValueFailure.invalidLimit({
    required T failedValue,
  }) = _InvalidLimit<T>;

  const factory CommonValueFailure.invalidFileName({
    required T failedValue,
  }) = _InvalidFileName<T>;

  const factory CommonValueFailure.invalidFileType({
    required T failedValue,
  }) = _InvalidFileType<T>;

  const factory CommonValueFailure.invalidEmail({
    required T failedValue,
  }) = _InvalidEmail<T>;

  const factory CommonValueFailure.invalidUUID({
    required T failedValue,
  }) = InvalidUUID<T>;

  const factory CommonValueFailure.invalidPhoneNumber({
    required T failedValue,
  }) = _InvalidPhoneNumber<T>;

  const factory CommonValueFailure.invalidLogin({
    required T failedValue,
  }) = _InvalidLogin<T>;

  const factory CommonValueFailure.invalidDate({
    required T failedValue,
  }) = _InvalidDate<T>;

  const factory CommonValueFailure.invalidBirthDate({
    required T failedValue,
  }) = _InvalidBirthDate<T>;

  const factory CommonValueFailure.invalidPersonName({
    required T failedValue,
  }) = _InvalidPersonName<T>;

  const factory CommonValueFailure.shortPassword({
    required T failedValue,
  }) = _ShortPassword<T>;

  const factory CommonValueFailure.inputNotNumber({
    required T failedValue,
  }) = _NotNumber<T>;

  const factory CommonValueFailure.isNegative({
    required T failedValue,
  }) = _IsNegative<T>;

  const factory CommonValueFailure.numberOutOfRange({
    required T failedValue,
    num? min,
    num? max,
  }) = _OutOfRange<T>;

  const factory CommonValueFailure.numberTooSmall({
    required T failedValue,
    required num min,
  }) = _NumberTooSmall<T>;

  const factory CommonValueFailure.valueNotNull({
    required T failedValue,
  }) = _ValueIsNotNull;

  const factory CommonValueFailure.requiredValueIsNull({
    required T failedValue,
  }) = _RequiredValueIsNull;

  const factory CommonValueFailure.incompatibleValues({
    required T failedValue,
  }) = _IncompatibleValues<T>;

  const factory CommonValueFailure.nan({
    required T failedValue,
  }) = _NAN<T>;
}

class _InvalidValue<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidValue({
    required this.failedValue,
  });
}

class _InsufficientLength<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;
  final num min;

  const _InsufficientLength({
    required this.failedValue,
    required this.min,
  });
}

class _ExceedingLength<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;
  final int max;

  const _ExceedingLength({
    required this.failedValue,
    required this.max,
  });
}

class _InvalidLength<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;
  final num requiredLength;

  const _InvalidLength({
    required this.failedValue,
    required this.requiredLength,
  });
}

class _Empty<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _Empty({
    required this.failedValue,
  });
}

class _Multiline<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _Multiline({
    required this.failedValue,
  });
}

class _NumberTooLarge<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;
  final num max;

  const _NumberTooLarge({
    required this.failedValue,
    required this.max,
  });
}

class _InvalidLimit<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidLimit({
    required this.failedValue,
  });
}

class _InvalidFileName<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidFileName({
    required this.failedValue,
  });
}

class _InvalidFileType<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidFileType({
    required this.failedValue,
  });
}

class _InvalidEmail<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidEmail({
    required this.failedValue,
  });
}

class InvalidUUID<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const InvalidUUID({
    required this.failedValue,
  });
}

class _InvalidPhoneNumber<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidPhoneNumber({
    required this.failedValue,
  });
}

class _InvalidLogin<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidLogin({
    required this.failedValue,
  });
}

class _InvalidDate<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidDate({
    required this.failedValue,
  });
}

class _InvalidBirthDate<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidBirthDate({
    required this.failedValue,
  });
}

class _InvalidPersonName<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _InvalidPersonName({
    required this.failedValue,
  });
}

class _ShortPassword<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _ShortPassword({
    required this.failedValue,
  });
}

class _NotNumber<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _NotNumber({
    required this.failedValue,
  });
}

class _IsNegative<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _IsNegative({
    required this.failedValue,
  });
}

class _OutOfRange<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;
  final num? min;
  final num? max;

  const _OutOfRange({
    required this.failedValue,
    this.min,
    this.max,
  });
}

class _NumberTooSmall<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;
  final num min;

  const _NumberTooSmall({
    required this.failedValue,
    required this.min,
  });
}

class _ValueIsNotNull<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _ValueIsNotNull({
    required this.failedValue,
  });
}

class _RequiredValueIsNull<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _RequiredValueIsNull({
    required this.failedValue,
  });
}

class _IncompatibleValues<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _IncompatibleValues({
    required this.failedValue,
  });
}

class _NAN<T> extends CommonValueFailure<T> {
  @override
  final T failedValue;

  const _NAN({
    required this.failedValue,
  });
}
