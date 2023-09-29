import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  final String imageUrl;

  const CharacterImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
