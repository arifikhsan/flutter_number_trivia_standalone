import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_standalone/core/error/failures.dart';
import 'package:flutter_number_trivia_standalone/core/usecases/usecase.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTriviaUsecase
    implements Usecase<NumberTriviaEntity, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTriviaUsecase(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTriviaEntity>> call(Params params) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(params.number);
  }
}
