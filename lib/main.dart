import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/bloc/character_bloc/character_event.dart';
import 'package:rick_and_morty_app/pages/auth_screen.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
import 'package:rick_and_morty_app/repositories/eposides_repository.dart';
import 'package:rick_and_morty_app/utils/my_app_theme.dart';
import 'package:rick_and_morty_app/widgets/loading_screen.dart';
import 'bloc/character_bloc/character_bloc.dart';
import 'bloc/character_bloc/character_state.dart';
import 'bloc/episodes_bloc/episode_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => CharacterRepository()),
        RepositoryProvider(create: (context) => EpisodesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CharacterBloc>(
            create: (context) => CharacterBloc(
              RepositoryProvider.of<CharacterRepository>(context),
            )..add(LoadCharacterAllEvent()),
          ),
          BlocProvider<EpisodeBloc>(
            create: (context) => EpisodeBloc(
              RepositoryProvider.of<EpisodesRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          theme: MyAppTheme.themeData,
          debugShowCheckedModeBanner: false,
          title: 'Rick and Morty',
          home: const CharacterLoadingOrHome(),
        ),
      ),
    );
  }
}

class CharacterLoadingOrHome extends StatelessWidget {
  const CharacterLoadingOrHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoadedState) {
          return const AuthScreen();
        } else {
          return const Scaffold(
            body: Center(child: LoadingScreen()),
          );
        }
      },
    );
  }
}
