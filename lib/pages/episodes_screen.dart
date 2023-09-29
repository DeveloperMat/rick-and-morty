import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/bloc/episodes_bloc/episode_bloc.dart';
import 'package:rick_and_morty_app/bloc/episodes_bloc/episode_events.dart';
import 'package:rick_and_morty_app/bloc/episodes_bloc/episode_states.dart';
import 'package:rick_and_morty_app/model/episodes_model.dart';
import 'package:rick_and_morty_app/repositories/eposides_repository.dart';
import 'package:rick_and_morty_app/widgets/custom_button.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EpisodeBloc(
        RepositoryProvider.of<EpisodesRepository>(context),
      )..add(LoadEpisodeEvent()),
      child: Scaffold(
        body: BlocBuilder<EpisodeBloc, EpisodeState>(builder: (context, state) {
          if (state is EpisodeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is EpisodeLoadedState) {
            List<EpisodesData> episodeList = state.episodes;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: episodeList.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 4,
                              child: ListTile(
                                title: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(episodeList[index].name!),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(episodeList[index].episode!),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(episodeList[index].airDate!),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                        width: 150,
                        text: 'Anterior',
                        onPressed: () {
                          // Lógica para ir a la página anterior
                          BlocProvider.of<EpisodeBloc>(context, listen: false)
                              .add(LoadPreviousEvent());
                        }),
                    const SizedBox(width: 16),
                    CustomElevatedButton(
                        width: 150,
                        text: 'Siguiente',
                        onPressed: () {
                          BlocProvider.of<EpisodeBloc>(context, listen: false)
                              .add(LoadNextPageEvent());
                        }),
                  ],
                ),
              ],
            );
          }
          if (state is EpisodeErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
