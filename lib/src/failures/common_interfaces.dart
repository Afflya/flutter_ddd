import 'package:dartz/dartz.dart';

import 'value_failures.dart';

abstract interface class Failure {}

abstract interface class Failable {
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit;
}

extension FailableX on Failable {
  bool isFailure() => failureOrUnit.isLeft();

  bool isValid() => failureOrUnit.isRight();
}
