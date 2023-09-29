import 'package:rick_and_morty_app/bloc/character_bloc/character_event.dart';
import 'package:rick_and_morty_app/bloc/character_bloc/character_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;
  List<CharacterResult> characterList = [];
  int currentPage = 1;

  CharacterBloc(this.characterRepository) : super(CharacterLoadingState()) {
    on<LoadCharacterEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final characters = await characterRepository.fetchData();
        emit(CharacterLoadedState(characters));
      } catch (e) {
        emit(CharacterErrorState(e.toString()));
      }
    });

    on<LoadCharacterAllEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final characters = await characterRepository.fetchAllData();
        characterList.addAll(characters);
        emit(CharacterLoadedState(characters));
      } catch (e) {
        emit(CharacterErrorState(e.toString()));
      }
    });

    on<LoadCharacterByIdEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final character =
            await characterRepository.fetchCharacterById(event.characterId);
        emit(CharacterLoadedState([character]));
      } catch (e) {
        emit(CharacterErrorState(e.toString()));
      }
    });
    on<LoadNextPageEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        currentPage++;
        final characters =
            await characterRepository.fetchData(page: currentPage);

        if (characters.isNotEmpty) {
          emit(CharacterLoadedState(characters));
        } else {
          emit(CharacterLoadedState(characters));
        }
      } catch (e) {
        emit(CharacterErrorState(e.toString()));
      }
    });

    on<LoadPreviousEvent>((event, emit) async {
      if (currentPage > 1) {
        emit(CharacterLoadingState());
        try {
          currentPage--;
          final characters =
              await characterRepository.fetchData(page: currentPage);

          if (characters.isNotEmpty) {
            emit(CharacterLoadedState(characters));
          } else {
            emit(CharacterLoadedState(characters));
          }
        } catch (e) {
          emit(CharacterErrorState(e.toString()));
        }
      }
    });
    on<SearchCharacterEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final query = event.query;
        final filteredCharacters = characterList.where((character) {
          return character.name!.toLowerCase().contains(query.toLowerCase());
        }).toList();

        emit(CharacterLoadedState(filteredCharacters));
      } catch (e) {
        emit(CharacterErrorState(e.toString()));
      }
    });
  }
}
