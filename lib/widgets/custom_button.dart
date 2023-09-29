import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: Size(
          width ?? double.infinity,
          height ?? 48.0,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Schyler',
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}
