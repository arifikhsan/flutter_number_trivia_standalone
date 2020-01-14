import 'dart:convert';

import 'package:flutter_number_trivia_standalone/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');

  test(
    'should be a subclass of NumberTriviaEntity',
    () async {
      // assert
      expect(testNumberTriviaModel, isA<NumberTriviaEntity>());
    },
  );

  group('fromJson', () {
    test(
      'should return valid model when the JSON number is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));

        // act
        final result = NumberTriviaModel.fromJson(jsonMap);

        // assert
        expect(result, testNumberTriviaModel);
      },
    );

    test(
      'should return valid model when the JSON number is regarded as a double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));

        // act
        final result = NumberTriviaModel.fromJson(jsonMap);

        // assert
        expect(result, testNumberTriviaModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = testNumberTriviaModel.toJson();

        // assert
        final expectedMap = {'text': 'test', 'number': 1};
        expect(result, expectedMap);
      },
    );
  });
}
