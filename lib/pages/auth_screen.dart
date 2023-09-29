import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/auth_helper.dart';
import '../widgets/custom_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

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
        _usernameController.text = storedUsername;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/wallpaper.jpg'),
                  opacity: 0.8,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Usuario',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa un usuario';
                          } else if (value.length < 3) {
                            return 'El usuario debe tener al menos 3 caracteres';
                          }
                          return null;
                        },
                        focusNode: _usernameFocus,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa una contraseña';
                          } else if (value.length < 5) {
                            return 'La contraseña debe tener al menos 5 caracteres';
                          }
                          return null;
                        },
                        focusNode: _passwordFocus,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 30.0,
                    left: 20.0,
                    right: 20.0), // Agrega el padding a los lados
                child: CustomElevatedButton(
                  onPressed: () {
                    AuthHelper.loginUser(
                        context, _usernameController, _formKey);
                  },
                  text: 'Iniciar Sesión',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose(); // Dispose de los FocusNode
    _passwordFocus.dispose();
    super.dispose();
  }
}
