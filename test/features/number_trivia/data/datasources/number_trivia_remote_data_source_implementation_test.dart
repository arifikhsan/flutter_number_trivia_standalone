import 'dart:convert';

import 'package:flutter_number_trivia_standalone/core/error/exceptions.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/data/datasources/number_trivia_remote_data_source_implementation.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImplementation dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource =
        NumberTriviaRemoteDataSourceImplementation(client: mockHttpClient);
  });

  void setUpMockHtppClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHtppClientSuccess404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 404));
  }

  void setUpMockHtppClientSuccess500() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 500));
  }

  group('getConcreteNumberTrivia', () {
    final testNumber = 1;
    final testNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a URL bodywith number 
          being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHtppClientSuccess200();

        // act
        dataSource.getConcreteNumberTrivia(testNumber);

        // assert
        verify(mockHttpClient.get(
          'http://numbersapi.com/$testNumber',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTriviaModel when the response code is 200',
      () async {
        // arrange
        setUpMockHtppClientSuccess200();

        // act
        final result = await dataSource.getConcreteNumberTrivia(testNumber);

        // assert
        expect(result, equals(testNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHtppClientSuccess404();

        // act
        final call = dataSource.getConcreteNumberTrivia;

        // assert
        expect(() => call(testNumber), throwsA(isInstanceOf<ServerException>()));
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setUpMockHtppClientSuccess500();

        // act
        final call = dataSource.getConcreteNumberTrivia;

        // assert
        expect(() => call(testNumber), throwsA(isInstanceOf<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final testNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a URL bodywith number 
          being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHtppClientSuccess200();

        // act
        dataSource.getRandomNumberTrivia();

        // assert
        verify(mockHttpClient.get(
          'http://numbersapi.com/random',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTriviaModel when the response code is 200',
      () async {
        // arrange
        setUpMockHtppClientSuccess200();

        // act
        final result = await dataSource.getRandomNumberTrivia();

        // assert
        expect(result, equals(testNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHtppClientSuccess404();

        // act
        final call = dataSource.getRandomNumberTrivia;

        // assert
        expect(call(), throwsA(isInstanceOf<ServerException>()));
      },
    );

    test(
      'should throw a ServerException when the response code is 500 or other',
      () async {
        // arrange
        setUpMockHtppClientSuccess500();

        // act
        final call = dataSource.getRandomNumberTrivia;

        // assert
        expect(call(), throwsA(isInstanceOf<ServerException>()));
      },
    );
  });
}
