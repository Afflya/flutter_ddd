import 'package:dartz/dartz.dart' hide id;
import 'package:uuid/uuid.dart';

import 'failures/value_failures.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      CommonValueFailure.exceedingLength(
        failedValue: input,
        max: maxLength,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateMinStringLength<T>(
  String input,
  int minLength,
) {
  if (input.length >= minLength) {
    return right(input);
  } else {
    return left(
      CommonValueFailure.insufficientLength(
        failedValue: input,
        min: minLength,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isEmpty) {
    return left(CommonValueFailure.empty(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return left(CommonValueFailure.multiline(failedValue: input));
  } else {
    return right(input);
  }
}

// Either<ValueFailure<List<T>>, List<T>> validateMaxListLength<T>(
//     List<T> input, int maxLength) {
//   if (input.length <= maxLength) {
//     return right(input);
//   } else {
//     return left(CollectionValueFailure.collectionTooLong(
//       failedValue: input,
//       max: maxLength,
//     ));
//   }
// }

Either<ValueFailure<String>, String> validateFileName(String input) {
  // const regex = r"""^.*\.[a-zA-Z]+$""";
  // if (RegExp(regex).hasMatch(input)) {
  //   return right(input);
  // } else {
  //   return left(CommonValueFailure.invalidFileName(failedValue: input));
  // }
  //TODO add check for specific characters
  return validateStringNotEmpty(input);
}

Either<ValueFailure<String>, String> validateFileType(String input) {
  // const regex = r"""^[a-zA-Z]+\/[a-zA-Z]+$""";
  const regex = r"""^\w+/[-.\w]+(?:\+[-.\w]+)?$""";
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.invalidFileType(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePersonName(String input) {
  const regex = '^[A-Za-zа-яА-Я]{2,40}\$';
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.invalidPersonName(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  // Maybe not the most robust way of email validation but it's good enough
  // const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  const emailRegex = r""".+@.+\..+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePhoneNumber(String input) {
  const regex = r"^(\+7[\- ]?|7[\- ]?|8[\- ]?)?(9[\d]{2}[\- ]?[\d]{3}([\- ]?[\d]{2}){2})$";
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.invalidPhoneNumber(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateLogin(String input) {
  const regex = r"""^[A-z0-9]+$""";
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.invalidLogin(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateFirmwareVersion(String input) {
  const regex = r"""^\d+(\.\d+){2,}$""";
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.invalidFileName(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateIsNumber(String input) {
  const regex = '^[0-9]*\$';
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.nan(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateUUID(String input) {
  if (Uuid.isValidUUID(fromString: input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.invalidUUID(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateDate(String input) {
  const dateRegex = r"""^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$""";
  if (RegExp(dateRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.invalidDate(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateBirthDate(String input) {
  return validateDate(input).fold(
    (f) {
      return left(f);
    },
    (_) {
      final split = input.split('-');
      final date = DateTime(
        int.parse(split[0]),
        int.parse(split[1]),
        int.parse(split[2]),
      );
      return date.isBefore(DateTime.now())
          ? right(input)
          : left(CommonValueFailure.invalidBirthDate(failedValue: input));
    },
  );
}

Either<ValueFailure<String>, String> validateNumericCode(
  String input,
  int length,
) {
  if (input.length != length) {
    return left(
      CommonValueFailure.invalidLength(
        failedValue: input,
        requiredLength: length,
      ),
    );
  }
  const regex = r"""^\d{6}$""";
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(CommonValueFailure.inputNotNumber(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  // You can also add some advanced password checks (uppercase/lowercase, at least 1 number, ...)
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(CommonValueFailure.shortPassword(failedValue: input));
  }
}

Either<ValueFailure<T>, T> validateNumberInRange<T extends num>(
  T input,
  num minValue,
  num maxValue,
) {
  if (input < minValue || input > maxValue) {
    return left(
      CommonValueFailure.numberOutOfRange(
        failedValue: input,
        min: minValue,
        max: maxValue,
      ),
    );
  } else {
    return right(input);
  }
}

Either<ValueFailure<T>, T> validateNumberAtLeast<T extends num>(
  T input,
  num minValue,
) {
  if (input < minValue) {
    return left(
      CommonValueFailure.numberTooSmall(failedValue: input, min: minValue),
    );
  } else {
    return right(input);
  }
}

Either<ValueFailure<T>, T> validateNumberLessThan<T extends num>(
  T input,
  num maxValue,
) {
  if (input > maxValue) {
    return left(
      CommonValueFailure.numberTooLarge(failedValue: input, max: maxValue),
    );
  } else {
    return right(input);
  }
}

Either<ValueFailure<T>, T> validateNumberIsPositive<T extends num>(T input) {
  if (input < 0) {
    return left(CommonValueFailure.isNegative(failedValue: input));
  } else {
    return right(input);
  }
}
