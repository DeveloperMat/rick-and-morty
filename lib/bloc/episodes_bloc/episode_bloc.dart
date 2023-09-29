import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/bloc/episodes_bloc/episode_events.dart';
import 'package:rick_and_morty_app/bloc/episodes_bloc/episode_states.dart';
import 'package:rick_and_morty_app/repositories/eposides_repository.dart';

import '../../model/episodes_model.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final EpisodesRepository episodesRepository;
  List<EpisodesData> lastLoadedEpisodes = [];

  int currentPage = 1;

  EpisodeBloc(this.episodesRepository) : super(EpisodeLoadingState()) {
    on<LoadEpisodeEvent>((event, emit) async {
      emit(EpisodeLoadingState());
      try {
        final episodes = await episodesRepository.fetchData();
        emit(EpisodeLoadedState(episodes));
      } catch (e) {
        emit(EpisodeErrorState(e.toString()));
      }
    });
    on<LoadEpisodeByIdEvent>((event, emit) async {
      emit(EpisodeLoadingState());
      try {
        final episodes =
            await episodesRepository.fetchEpisodeById(event.episodeID);
        emit(EpisodeLoadedState([episodes]));
      } catch (e) {
        emit(EpisodeErrorState(e.toString()));
      }
    });

    on<LoadNextPageEvent>((event, emit) async {
      if (currentPage < 3) {
        emit(EpisodeLoadingState());
        try {
          currentPage++;
          final episodes =
              await episodesRepository.fetchData(page: currentPage);

          if (episodes.isNotEmpty) {
            lastLoadedEpisodes = episodes;
            emit(EpisodeLoadedState(episodes));
          } else {
            emit(EpisodeLoadedState(lastLoadedEpisodes));
          }
        } catch (e) {
          emit(EpisodeErrorState(e.toString()));
        }
      }
    });
    on<LoadPreviousEvent>((event, emit) async {
      if (currentPage > 1) {
        emit(EpisodeLoadingState());
        try {
          currentPage--;
          final episodes =
              await episodesRepository.fetchData(page: currentPage);

          if (episodes.isNotEmpty) {
            emit(EpisodeLoadedState(episodes));
          } else {
            emit(EpisodeLoadedState(episodes));
          }
        } catch (e) {
          emit(EpisodeErrorState(e.toString()));
        }
      }
    });
  }
}
