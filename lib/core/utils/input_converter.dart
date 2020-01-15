import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_standalone/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String string) {
    try {
      final integer = int.parse(string);
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
