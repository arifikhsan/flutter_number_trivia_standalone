import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_standalone/core/error/failures.dart';
import 'package:flutter_number_trivia_standalone/core/usecases/usecase.dart';
import 'package:flutter_number_trivia_standalone/core/utils/input_converter.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';
import './bloc.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUsecase getConcreteNumberTrivia;
  final GetRandomNumberTriviaUsecase getRandomNumberTrivia;
  final InputConverter inputConverter;

  static const String SERVER_FAILURE_MESSAGE = 'Server failure';
  static const String CACHE_FAILURE_MESSAGE = 'Cache failure';
  static const String INVALID_INPUT_FAILURE_MESSAGE =
      'Invalid input - The number must be a positive integer';

  NumberTriviaBloc({
    @required GetConcreteNumberTriviaUsecase concrete,
    @required GetRandomNumberTriviaUsecase random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
        },
      );
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTriviaEntity> failureOrTrivia,
  ) async* {
    yield failureOrTrivia.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
        break;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
        break;
      default:
        return 'Unexpected Error';
    }
  }
}