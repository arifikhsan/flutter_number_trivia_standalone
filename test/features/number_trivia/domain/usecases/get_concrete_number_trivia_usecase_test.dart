import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_standalone/core/usecases/usecase.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTriviaUsecase usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTriviaUsecase(mockNumberTriviaRepository);
  });

  final testNumber = 1;
  final testNumberTrivia = NumberTriviaEntity(number: 1, text: 'test');

  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(testNumberTrivia));

      // act
      final result = await usecase(Params(number: testNumber));

      // assert
      expect(result, Right(testNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(testNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
