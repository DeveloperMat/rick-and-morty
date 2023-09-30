import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/bloc/character_bloc/character_bloc.dart';
import 'package:rick_and_morty_app/bloc/character_bloc/character_event.dart';
import 'package:rick_and_morty_app/bloc/character_bloc/character_state.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/pages/character_details_screen.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
import 'package:rick_and_morty_app/utils/utils.dart';

import '../widgets/character_image.dart';
import '../widgets/custom_button.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterBloc(
        RepositoryProvider.of<CharacterRepository>(context),
      )..add(LoadCharacterEvent()),
      child: Scaffold(
        body: BlocBuilder<CharacterBloc, CharacterState>(
            builder: (context, state) {
          if (state is CharacterLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CharacterLoadedState) {
            List characterList = state.characters;
            return Column(
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: characterList.length,
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          CharacterResult? character = characterList[index];
                          push(
                            context,
                            CharacterDetailsScreen(
                              character: character,
                            ),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Expanded(
                                child: CharacterImage(
                                    imageUrl: characterList[index].image!),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                characterList[index].name!,
                                style: const TextStyle(fontSize: 24),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      scrollDirection: Axis.vertical,
                      height: MediaQuery.of(context).size.height * 0.60,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      width: 150,
                      onPressed: () {
                        BlocProvider.of<CharacterBloc>(context, listen: false)
                            .add(LoadPreviousEvent());
                      },
                      text: 'Anterior',
                    ),
                    const SizedBox(width: 16),
                    CustomElevatedButton(
                      width: 150,
                      onPressed: () {
                        // Lógica para ir a la página anterior
                        BlocProvider.of<CharacterBloc>(context, listen: false)
                            .add(LoadNextPageEvent());
                      },
                      text: 'Siguiente',
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is CharacterErrorState) {
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
