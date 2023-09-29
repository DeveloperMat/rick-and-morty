import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF010024),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/rick-sanchez.gif',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Cargando...',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
