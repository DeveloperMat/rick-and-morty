import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rick_and_morty_app/bloc/character_bloc/character_bloc.dart';
import '../model/character_model.dart';

class BackgroundWidget extends StatefulWidget {
  final PageController pageController;

  const BackgroundWidget({Key? key, required this.pageController})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BackgroundWidgetState createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    final character = BlocProvider.of<CharacterBloc>(context).characterList;

    return CarouselSlider.builder(
      itemCount: character.length,
      itemBuilder: (context, index, realIndex) {
        return buildBackground(character, index);
      },
      options: CarouselOptions(
        reverse: true,
        autoPlay: true,
        viewportFraction: 1.0,
        aspectRatio: MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  Widget buildBackground(List<CharacterResult> character, int index) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.network(
            character[index].image!,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.15, 0.75],
              colors: [Colors.black.withOpacity(0.0001), Colors.black],
            ),
          ),
        )
      ],
    );
  }
}
