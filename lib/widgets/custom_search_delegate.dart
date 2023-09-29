import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/character_bloc/character_bloc.dart';
import '../bloc/character_bloc/character_event.dart';
import '../bloc/character_bloc/character_state.dart';

class CustomSearchDelegate extends SearchDelegate {
  final CharacterBloc characterBloc;

  CustomSearchDelegate(this.characterBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    characterBloc.add(SearchCharacterEvent(query));
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoadedState) {
          return ListView.builder(
            itemCount: state.characters.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  final character = state.characters[index];
                  Navigator.pop(context, character);
                },
                child: Card(
                  color: Colors.transparent,
                  elevation: 4,
                  child: ListTile(
                    title: Text(state.characters[index].name!),
                    leading: Image.network(state.characters[index].image!),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    characterBloc.add(SearchCharacterEvent(query));
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoadedState) {
          return ListView.builder(
            itemCount: state.characters.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  final character = state.characters[index];
                  Navigator.pop(context, character);
                },
                child: Card(
                  color: Colors.transparent,
                  elevation: 4,
                  child: ListTile(
                    title: Text(state.characters[index].name!),
                    leading: Image.network(state.characters[index].image!),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
