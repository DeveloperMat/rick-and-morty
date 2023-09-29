import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/model/episodes_model.dart';

@immutable
abstract class EpisodeState extends Equatable {}

class EpisodeLoadingState extends EpisodeState {
  @override
  List<Object?> get props => [];
}

class EpisodeLoadedState extends EpisodeState {
  EpisodeLoadedState(this.episodes);
  final List<EpisodesData> episodes;
  @override
  List<Object?> get props => [episodes];
}

class EpisodeErrorState extends EpisodeState {
  EpisodeErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
