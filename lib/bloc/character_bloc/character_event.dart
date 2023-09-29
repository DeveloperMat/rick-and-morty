import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CharacterEvent extends Equatable {}

class LoadCharacterEvent extends CharacterEvent {
  @override
  List<Object?> get props => [];
}

class LoadCharacterAllEvent extends CharacterEvent {
  @override
  List<Object?> get props => [];
}

class LoadCharacterByIdEvent extends CharacterEvent {
  final int characterId;

  LoadCharacterByIdEvent(this.characterId);

  @override
  List<Object?> get props => [characterId];
}

class SearchCharacterEvent extends CharacterEvent {
  final String query;

  SearchCharacterEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadNextPageEvent extends CharacterEvent {
  @override
  List<Object?> get props => [];
}

class LoadPreviousEvent extends CharacterEvent {
  @override
  List<Object?> get props => [];
}
