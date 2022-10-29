import 'package:dartz/dartz.dart';

import 'value_failures.dart';

abstract class Failure {}

abstract class IFailable {
  Either<ValueFailure<dynamic>, Unit> get failureOrUnit;
}

extension IFailableX on IFailable {
  bool isFailure() => failureOrUnit.isLeft();

  bool isValid() => failureOrUnit.isRight();
}
