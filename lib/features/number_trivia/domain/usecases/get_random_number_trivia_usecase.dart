import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_standalone/core/error/failures.dart';
import 'package:flutter_number_trivia_standalone/core/usecases/usecase.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTriviaUsecase implements Usecase<NumberTriviaEntity, Noparams> {
  final NumberTriviaRepository numberTriviaRepository;

  GetRandomNumberTriviaUsecase(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(Noparams params) async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}
