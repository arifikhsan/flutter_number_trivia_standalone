import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_standalone/core/usecases/usecase.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTriviaUsecase getRandomNumberTriviaUsecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    getRandomNumberTriviaUsecase =
        GetRandomNumberTriviaUsecase(mockNumberTriviaRepository);
  });

  final testNumberTrivia = NumberTriviaEntity(number: 1, text: 'test');

  test(
    'should get random trivia from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(testNumberTrivia));

      // act
      final result = await getRandomNumberTriviaUsecase(Noparams());

      // assert
      expect(result, Right(testNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
