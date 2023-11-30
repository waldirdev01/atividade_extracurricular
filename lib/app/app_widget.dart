import 'package:controle_atividade_extracurricular/app/modules/admin/home/home_page.dart';
import 'package:controle_atividade_extracurricular/app/modules/auth/register/register_page.dart';
import 'package:controle_atividade_extracurricular/app/modules/pollo/pollo_home_page.dart';
import 'package:controle_atividade_extracurricular/app/modules/splash/splash_page.dart';
import 'package:controle_atividade_extracurricular/app/provider/atividade_extracurricular_provider.dart';
import 'package:controle_atividade_extracurricular/app/widgets/atividade_extracurricular_form.dart';
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
          ChangeNotifierProvider(
              create: (_) => AtividadeExtracurricularProvider()),
        ],
        child: MaterialApp(
          locale: const Locale('pt', 'BR'),
          theme: customTheme,
          debugShowCheckedModeBanner: false,
          home: PolloHomePage(),
          title: 'Controle de Atividades Extracurriculares',
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
