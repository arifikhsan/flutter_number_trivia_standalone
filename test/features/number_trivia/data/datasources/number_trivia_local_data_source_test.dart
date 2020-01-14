import 'dart:convert';

import 'package:flutter_number_trivia_standalone/core/error/exceptions.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/data/datasources/number_trivia_local_data_source_implementation.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImplementation dataSrouce;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSrouce = NumberTriviaLocalDataSourceImplementation(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cache.json')));
    test(
      'should return NumberTrivia from SharedPreferences when thereis one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(
          fixture('trivia_cache.json'),
        );

        // act
        final result = await dataSrouce.getLastNumberTrivia();

        // assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a CacheException when there is no cache value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA))
            .thenReturn(null);

        // act
        final call = dataSrouce.getLastNumberTrivia;

        // assert
        expect(call(), throwsA(isInstanceOf<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    final testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');

    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        dataSrouce.cacheNumberTrivia(testNumberTriviaModel);

        // assert
        final expectedJsonString = json.encode(testNumberTriviaModel.toJson());
        verify(mockSharedPreferences.setString(
            CACHED_NUMBER_TRIVIA, expectedJsonString));
      },
    );
  });
}
