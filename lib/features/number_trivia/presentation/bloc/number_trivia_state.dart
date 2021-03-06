import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_trivia_standalone/features/number_trivia/domain/entities/number_trivia_entity.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class Empty extends NumberTriviaState {
  @override
  List<Object> get props => null;
}

class Loading extends NumberTriviaState {
  @override
  List<Object> get props => null;
}

class Loaded extends NumberTriviaState {
  final NumberTriviaEntity trivia;

  Loaded({@required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
