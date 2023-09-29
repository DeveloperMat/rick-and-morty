import 'package:flutter/material.dart';

class CharacterInfo extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String value;

  const CharacterInfo({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                imageUrl,
                width: 50,
              ),
              const SizedBox(width: 10),
              Text(
                value,
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
