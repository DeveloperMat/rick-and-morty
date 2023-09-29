// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/pages/home_screen.dart';
import 'package:rick_and_morty_app/utils/utils.dart';
import '../bloc/character_bloc/character_bloc.dart';
import '../widgets/custom_search_delegate.dart';

class CharacterDetailsScreen extends StatefulWidget {
  CharacterResult? character;
  CharacterDetailsScreen({super.key, this.character});

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  CharacterResult? selectedCharacter;

  @override
  Widget build(BuildContext context) {
    final characterBloc = BlocProvider.of<CharacterBloc>(context);
    final character = characterBloc.characterList;

    // ignore: no_leading_underscores_for_local_identifiers
    void _startSearch() async {
      final character = await showSearch(
        context: context,
        delegate: CustomSearchDelegate(characterBloc),
      );

      if (character != null) {
        setState(() {
          selectedCharacter = character;
        });
      }
    }

    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(selectedCharacter?.image ??
                            widget.character?.image ??
                            character[0].image!),
                        fit: BoxFit.cover,
                        opacity: 0.8),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        push(context, HomeScreen());
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            characterInfo(character, selectedCharacter: selectedCharacter),
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _startSearch,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: const Icon(Icons.search),
      ),
    );
  }

  Padding characterInfo(List<CharacterResult> character,
      {CharacterResult? selectedCharacter}) {
    final characterToUse =
        widget.character != null ? widget.character! : character[0];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selectedCharacter?.name ?? characterToUse.name!,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Image.asset(
                'assets/images/genero-img.png',
                width: 50,
              ),
              const SizedBox(width: 10),
              Text(
                'Género: ${selectedCharacter?.gender?.toString().substring('Gender.'.length) ?? characterToUse.gender!.toString().substring('Gender.'.length)}',
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/especie-img.png',
                width: 50,
              ),
              const SizedBox(width: 10),
              Text(
                "Especie: ${selectedCharacter?.species?.toString().substring('Species.'.length) ?? characterToUse.species.toString().substring('Species.'.length)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                'assets/images/origen-img.png',
                width: 50,
              ),
              const SizedBox(width: 10),
              Text(
                "Origen: ${selectedCharacter?.origin?.name ?? characterToUse.origin!.name}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                'assets/images/estatus-img.png',
                width: 50,
              ),
              const SizedBox(width: 10),
              Text(
                "Estatus: ${selectedCharacter?.status?.name ?? characterToUse.status!.name}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
