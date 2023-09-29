import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/bloc/character_bloc/character_bloc.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/pages/auth_screen.dart';
import 'package:rick_and_morty_app/pages/character_details_screen.dart';
import 'package:rick_and_morty_app/pages/character_screen.dart';
import 'package:rick_and_morty_app/pages/episodes_screen.dart';
import 'package:rick_and_morty_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/character_image.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String? username;
  HomeScreen({super.key, this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _username = "Invitado";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      setState(() {
        _username = storedUsername;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final characterBloc = BlocProvider.of<CharacterBloc>(context).characterList;
    final controller = PageController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rick and Morty App",
          style: TextStyle(color: Color(0xff61BE25), fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              pushAndRemoveUntil(context, const AuthScreen(), false);
            },
          ),
        ],
      ),
      body: _buildPage(_selectedIndex, characterBloc, controller),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/inicio.png',
              width: 20,
              height: 20,
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/detalles.png',
              width: 20,
              height: 20,
            ),
            label: 'Detalles',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/episodios.png',
              width: 20,
              height: 20,
            ),
            label: 'Episodios',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/personajes.png',
              width: 20,
              height: 20,
            ),
            label: 'Personajes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xffCDDE53),
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildPage(int index, List<CharacterResult> characterList, c) {
    switch (index) {
      case 0:
        return _buildHomePage(characterList);
      case 1:
        return CharacterDetailsScreen();
      case 2:
        return const EpisodesScreen();
      case 3:
        return const CharactersScreen();
      default:
        return Container();
    }
  }

  Widget _buildHomePage(List<CharacterResult> characterList) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/especie-img.png',
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 8),
              Text(
                "Bienvenido $_username",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            CarouselSlider.builder(
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
                height: MediaQuery.of(context).size.height * 0.60,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
