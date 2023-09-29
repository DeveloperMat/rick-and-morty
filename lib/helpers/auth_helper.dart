import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_screen.dart';
import '../utils/utils.dart';

class AuthHelper {
  static Future<void> loginUser(
      BuildContext context,
      TextEditingController usernameController,
      GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      final username = usernameController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
      // ignore: use_build_context_synchronously
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 300));
      // ignore: use_build_context_synchronously
      pushAndRemoveUntil(
        context,
        HomeScreen(username: username),
        false,
      );
    }
  }
}
