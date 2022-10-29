import 'package:dartz/dartz.dart' hide id;
import 'package:dartz/dartz.dart' as dz show id;
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'errors.dart';
import 'failures/common_interfaces.dart';
import 'failures/value_failures.dart';
import 'value_validators.dart';

@immutable
abstract class ValueObject<T> with IFailable {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw UnexpectedValueError(f), dz.id);
  }

  T getOrElse(T defaultValue) {
    return value.fold((l) => defaultValue, (r) => r);
  }

  T? getOrNull() {
    return value.fold((l) => null, (r) => r);
  }

  T getIgnoringFailure() {
    return value.fold((f) => f.failedValue, (v) => v);
  }

  @override
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
          (l) => left(l),
          (r) => right(unit),
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

extension OptionX<T> on Option<T> {
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return fold(
          () => right(unit),
          (v) {
        if (v is IFailable) {
          return v.failureOrUnit;
        } else if (v is Iterable) {
          return v.failureOrUnit;
        } else {
          return right(unit);
        }
      },
    );
  }

  T getOrCrash() {
    return fold(() => throw NullValueOptionError(), (v) => v);
  }
}

extension EitherX<L, R> on Either<L, R> {
  L? leftOrNull() {
    return fold((l) => l, (r) => null);
  }

  L leftOrCrash() {
    return fold((l) => l, (r) => throw EitherIsRightError());
  }

  R? rightOrNull() {
    return fold((l) => null, (r) => r);
  }

  R rightOrCrash() {
    return fold((l) => throw EitherIsLeftError(), (r) => r);
  }
}

extension IterableFailureX<T> on Iterable<T> {
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return map<Either<ValueFailure<dynamic>, Unit>>((element) {
      if (element is IFailable) {
        return element.failureOrUnit;
      } else if (element is Iterable) {
        return element.failureOrUnit;
      } else {
        return right(unit);
      }
    }).firstWhere(
          (element) => element.isLeft(),
      orElse: () => right(unit),
    );
  }
}

extension MapEntryFailure<K, V> on MapEntry<K, V> {
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    Either<ValueFailure<dynamic>, Unit>? res;
    if (key is IFailable) {
      res = (key as IFailable).failureOrUnit;
      if (res.isLeft()) {
        return res;
      }
    } else if (key is Iterable) {
      res = (key as Iterable).failureOrUnit;
      if (res.isLeft()) {
        return res;
      }
    }

    if (value is IFailable) {
      return (value as IFailable).failureOrUnit;
    } else if (value is Iterable) {
      return (value as Iterable).failureOrUnit;
    }
    return right(unit);
  }
}

extension MapFailure<K, V> on Map<K, V> {
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return entries.map((e) => e.failureOrUnit).firstWhere(
          (element) => element.isLeft(),
      orElse: () => right(unit),
    );
  }
}

class UniqueIdTimestamp extends ValueObject<int> {
  @override
  final Either<ValueFailure<int>, int> value;

  factory UniqueIdTimestamp(int timestamp) {
    return UniqueIdTimestamp._(
      validateNumberIsPositive(timestamp),
    );
  }

  factory UniqueIdTimestamp.now() {
    return UniqueIdTimestamp._(
      right(DateTime
          .now()
          .millisecondsSinceEpoch),
    );
  }

  /// Used with strings we trust are unique, such as database IDs.
  factory UniqueIdTimestamp.fromDateTime(DateTime dateTime) {
    return UniqueIdTimestamp(dateTime.millisecondsSinceEpoch);
  }

  const UniqueIdTimestamp._(this.value);
}

extension UniqueIdTimestampX on UniqueIdTimestamp {
  DateTime? toDateTime() {
    return value.fold(
          (_) => null,
          (v) => DateTime.fromMillisecondsSinceEpoch(v),
    );
  }
}

class UniqueIdUInt extends ValueObject<int> {
  @override
  final Either<ValueFailure<int>, int> value;

  factory UniqueIdUInt(int input) {
    return UniqueIdUInt._(
      validateNumberIsPositive(input),
    );
  }

  const UniqueIdUInt._(this.value);
}

class UniqueIdNumber extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueIdNumber(String input) {
    return UniqueIdNumber._(
      validateIsNumber(input),
    );
  }

  const UniqueIdNumber._(this.value);
}

class UniqueIdUUID extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueIdUUID(String input) {
    return UniqueIdUUID._(
      validateUUID(input),
    );
  }

  factory UniqueIdUUID.random() {
    //wont regenerate with const
    //ignore: prefer_const_constructors
    return UniqueIdUUID(Uuid().v1());
  }

  const UniqueIdUUID._(this.value);
}

final UniqueIdUUID emptyUuid = UniqueIdUUID(UuidValue
    .fromByteList(Uint8List(16))
    .uuid);

final UniqueIdNumber emptyNumStrId = UniqueIdNumber('0');

final UniqueIdUInt emptyIntId = UniqueIdUInt(0);

abstract class NumberInRange<T extends num> extends ValueObject<T> {
  @override
  final Either<ValueFailure<T>, T> value;

  NumberInRange(T value, T min, T max) : value = validateNumberInRange(value, min, max);
}

class FileName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory FileName(String input) {
    return FileName._(
      validateFileName(input),
    );
  }

  const FileName._(this.value);
}

class FileType extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory FileType(String input) {
    return FileType._(
      validateFileType(input),
    );
  }

  const FileType._(this.value);
}

class StringSingleLine extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory StringSingleLine(String input) {
    return StringSingleLine._(
      validateSingleLine(input),
    );
  }

  const StringSingleLine._(this.value);
}

class NonEmptyString extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory NonEmptyString(String input) {
    return NonEmptyString._(
      validateStringNotEmpty(input),
    );
  }

  const NonEmptyString._(this.value);
}

class NonEmptyStringSingleLine extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory NonEmptyStringSingleLine(String input) {
    return NonEmptyStringSingleLine._(
      validateSingleLine(input).flatMap(validateStringNotEmpty),
    );
  }

  const NonEmptyStringSingleLine._(this.value);
}

class ShortLengthString extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 50;

  factory ShortLengthString(String input) {
    return ShortLengthString._(
      validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty).flatMap(validateSingleLine),
    );
  }

  const ShortLengthString._(this.value);
}

class MediumLengthString extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 150;

  factory MediumLengthString(String input) {
    return MediumLengthString._(
      validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty).flatMap(validateSingleLine),
    );
  }

  const MediumLengthString._(this.value);
}

class LongString extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 500;

  factory LongString(String input) {
    return LongString._(
      validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty).flatMap(validateSingleLine),
    );
  }

  const LongString._(this.value);
}

class FirmwareVersion extends ValueObject<String> implements Comparable<FirmwareVersion> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory FirmwareVersion(String input) {
    return FirmwareVersion._(
      validateFirmwareVersion(input),
    );
  }

  const FirmwareVersion._(this.value);

  @override
  int compareTo(FirmwareVersion other) {
    assert(isValid() && other.isValid(), 'Firmware versions must be valid (this: $this, other: $other})');

    final values = getIgnoringFailure().split('.').map(int.parse).toList();
    final otherValues = other.getIgnoringFailure().split('.').map(int.parse).toList();

    if (values.length < otherValues.length) {
      values.addAll(List.generate(otherValues.length - values.length, (_) => 0));
    } else if (values.length > otherValues.length) {
      otherValues.addAll(List.generate(values.length - otherValues.length, (_) => 0));
    }

    for (int i = 0; i < values.length; i++) {
      final result = values[i].compareTo(otherValues[i]);
      if (result != 0) return result;
    }

    return 0;
  }
}

class PhoneNumber extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PhoneNumber(String input) {
    return PhoneNumber._(
      validatePhoneNumber(input),
    );
  }

  const PhoneNumber._(this.value);

  String getOrCrashFormatted() {
    final str = getOrCrash();
    if (str.startsWith('+')) {
      return str;
    } else if (str.startsWith('8')) {
      return str.replaceRange(0, 1, '+7');
    } else {
      return '+$str';
    }
  }
}

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}

class Login extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Login(String input) {
    return Login._(
      validateLogin(input),
    );
  }

  const Login._(this.value);
}

class UDouble extends ValueObject<double> {
  @override
  final Either<ValueFailure<double>, double> value;

  factory UDouble(double input) {
    return UDouble._(
      validateNumberIsPositive(input),
    );
  }

  const UDouble._(this.value);
}

class UInt extends ValueObject<int> {
  @override
  final Either<ValueFailure<int>, int> value;

  factory UInt(int input) {
    return UInt._(
      validateNumberIsPositive(input),
    );
  }

  const UInt._(this.value);
}

class UShort extends ValueObject<int> {
  static const min = 0;
  static const max = 65535;

  @override
  final Either<ValueFailure<int>, int> value;

  factory UShort(int input) {
    return UShort._(validateNumberInRange(input, min, max));
  }

  const UShort._(this.value);

  int compareTo(UShort other) {
    if (other.getOrCrash() > getOrCrash()) {
      return -1;
    } else if (other.getOrCrash() < getOrCrash()) {
      return 1;
    }
    return 0;
  }
}

class UByte extends ValueObject<int> {
  static const min = 0;
  static const max = 255;

  @override
  final Either<ValueFailure<int>, int> value;

  factory UByte(int input) {
    return UByte._(validateNumberInRange(input, min, max));
  }

  const UByte._(this.value);
}
