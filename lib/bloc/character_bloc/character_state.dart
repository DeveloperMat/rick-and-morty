import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../../model/character_model.dart';

@immutable
abstract class CharacterState extends Equatable {}

class CharacterLoadingState extends CharacterState {
  @override
  List<Object?> get props => [];
}

class CharacterLoadedState extends CharacterState {
  CharacterLoadedState(this.characters);
  final List<CharacterResult> characters;
  @override
  List<Object?> get props => [characters];
}

class CharacterErrorState extends CharacterState {
  CharacterErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
