import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_standalone/core/error/failures.dart';
import 'package:flutter_number_trivia_standalone/core/utils/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInteger', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () async {
        // arrange
        final String string = '123';

        // act
        final result = inputConverter.stringToUnsignedInteger(string);

        // assert
        expect(result, Right(123));
      },
    );

    test(
      'should return a Failure when the string is not an integer',
      () async {
        // arrange
        final string = 'abc';
        
        // act
        final result = inputConverter.stringToUnsignedInteger(string);

        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );

    test(
      'should return a Failure when the string is a negative integer',
      () async {
        // arrange
        final string = '-123';

        // act
        final result = inputConverter.stringToUnsignedInteger(string);

        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
