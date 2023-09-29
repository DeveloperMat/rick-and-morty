import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class EpisodeEvent extends Equatable {}

class LoadEpisodeEvent extends EpisodeEvent {
  @override
  List<Object?> get props => [];
}

class LoadEpisodeByIdEvent extends EpisodeEvent {
  final int episodeID;

  LoadEpisodeByIdEvent(this.episodeID);

  @override
  List<Object?> get props => [episodeID];
}

class LoadNextPageEvent extends EpisodeEvent {
  @override
  List<Object?> get props => [];
}

class LoadPreviousEvent extends EpisodeEvent {
  @override
  List<Object?> get props => [];
}
