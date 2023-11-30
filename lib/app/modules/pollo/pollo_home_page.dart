import 'package:controle_atividade_extracurricular/app/models/atividade_extracurricular.dart';
import 'package:controle_atividade_extracurricular/app/provider/atividade_extracurricular_provider.dart';
import 'package:controle_atividade_extracurricular/app/widgets/atividade_extracurricular_card.dart';
import 'package:controle_atividade_extracurricular/app/widgets/atividade_extracurricular_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PolloHomePage extends StatelessWidget {
  const PolloHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final atividadeProvider =
        Provider.of<AtividadeExtracurricularProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pollo Home Page'),
      ),
      body: FutureBuilder<List<AtividadeExtracurricular>>(
        future: atividadeProvider.getAtividades(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.error != null) {
            return const Center(child: Text('Ocorreu um erro.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma atividade encontrada.'));
          }

          List<AtividadeExtracurricular> _atividades = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.builder(
              itemCount: _atividades.length,
              itemBuilder: (context, index) {
                return AtividadeExtracurricularCard(
                    atividade: _atividades[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
