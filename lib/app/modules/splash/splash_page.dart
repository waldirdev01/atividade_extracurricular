// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'package:controle_atividade_extracurricular/app/modules/admin/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_user.dart';
import '../../provider/app_user_provider.dart';
import '../auth/login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final splashDuration = const Duration(seconds: 3);
  late Timer _timer;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _timer = Timer(splashDuration, _navigate);
  }

  Future<void> _navigate() async {
    final appUserProvider =
        Provider.of<AppUserProvider>(context, listen: false);
    final appUser = await appUserProvider.getCurrentUser();

    if (appUser != null) {
      switch (appUser.type) {
        case UserType.newUser:
          loading = false;
          break;
        case UserType.pollo:
          //navegar para Pollo
          break;
        case UserType.transfer:
          //transfer
          break;
        case UserType.admin:
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false);
          break;
      }
    } else {}
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 200,
            child: Image.asset('assets/images/bus.jpg'),
          ),
          Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 12,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CRE-PARANOÁ',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                ],
              )),
          Positioned(
            right: 50,
            bottom: 50,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Seja bem-vindo(a)!',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  !loading
                      ? const Text(
                          'Aguarde a aprovação do seu cadastro.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  const Divider(),
                  TextButton(
                      onPressed: () {
                        AppUserProvider().signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      },
                      child: const Text(
                        'SAIR',
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
