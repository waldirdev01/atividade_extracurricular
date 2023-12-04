import 'package:controle_atividade_extracurricular/app/models/atividade_extracurricular.dart';
import 'package:controle_atividade_extracurricular/app/modules/splash/splash_page.dart';
import 'package:controle_atividade_extracurricular/app/provider/atividade_extracurricular_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class AtividadeExtracurricularCard extends StatelessWidget {
  final AtividadeExtracurricular atividade;

  const AtividadeExtracurricularCard({super.key, required this.atividade});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DATA: ${DateFormat('dd/MM/yyyy').format(atividade.data)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(atividade.company,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            const SizedBox(
              height: 8,
            ),
            Text(
              'NOME DA ESCOLA: ${atividade.nomeEscola}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'EVENTO: ${atividade.nomeAtividade}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'USUÁRIO: ${atividade.userMail}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOCAL: ${atividade.local}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'TURNO: ${atividade.turno}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'HORÁRIO: ${atividade.horario}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'TOTAL DE ÔNIBUS: ${atividade.totalOnibus}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'TOTAL DE ALUNOS: ${atividade.totalAlunos}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'TOTAL DE PROFESSORES: ${atividade.totalProfessores}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'PERCURSO TOTAL POR ÔNIBUS: ${atividade.percursoTotal} km (ida e volta).',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'STATUS: ${atividade.status}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'LISTA DE ESTUDANTES',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        // Isso fará o ListView ocupar apenas o espaço necessário
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: atividade.students.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Text(atividade.students[index]),
                          );
                        })
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
