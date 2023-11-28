import 'package:controle_atividade_extracurricular/app/modules/auth/register/register_page.dart';
import 'package:controle_atividade_extracurricular/app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/auth/login/login_page.dart';
import 'provider/app_user_provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppUserProvider()),
        ],
        child: MaterialApp(
          theme: customTheme,
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
        ));
  }
}

final ThemeData customTheme = ThemeData(
  colorScheme: const ColorScheme.light(
      onError: Colors.red,
      primary: Colors.black,
      secondary: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: Colors.red),
  primaryColor: Colors.black,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      elevation: 2,
      backgroundColor: Colors.black,
      minimumSize: const Size(50, 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),
);
