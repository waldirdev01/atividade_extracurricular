import 'package:controle_atividade_extracurricular/app/widgets/atividade_extracurricular_card.dart';
import 'package:flutter/material.dart';

class PolloHomePage extends StatelessWidget {
  const PolloHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pollo Home Page',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center),
      ),
      body: Center(
        child: ListView(
          children: [
            AtividadeExtracurricularCard(),
            const SizedBox(
              height: 10,
            ),
            AtividadeExtracurricularCard(),
            const SizedBox(
              height: 10,
            ),
            AtividadeExtracurricularCard(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Voltar',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
