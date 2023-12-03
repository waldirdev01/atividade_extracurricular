import 'package:controle_atividade_extracurricular/app/models/atividade_extracurricular.dart';
import 'package:controle_atividade_extracurricular/app/modules/auth/login/login_page.dart';
import 'package:controle_atividade_extracurricular/app/provider/app_user_provider.dart';
import 'package:controle_atividade_extracurricular/app/provider/atividade_extracurricular_provider.dart';
import 'package:controle_atividade_extracurricular/app/widgets/atividade_extracurricular_card.dart';
import 'package:controle_atividade_extracurricular/app/widgets/atividade_extracurricular_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class PolloHomePage extends StatelessWidget {
  const PolloHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pollo Home Page'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AtividadeExtracurricularForm(),
                ),
              ),
              icon: Icon(Icons.add),
            ),
          ),
          IconButton(
              onPressed: () {
                AppUserProvider().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              icon: Icon(
                Icons.exit_to_app,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<AtividadeExtracurricularProvider>(
            builder: (_, atvidadeExt, child) {
          atvidadeExt.getAtividades();
          List<AtividadeExtracurricular> _atividades = atvidadeExt.atividades;
          return ListView.builder(
            itemCount: _atividades.length,
            itemBuilder: (context, index) {
              return Slidable(
                startActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      atvidadeExt.deleteAtividade(_atividades[index]);
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                    backgroundColor: Colors.red,
                  ),
                ]),
                endActionPane: ActionPane(
                  extentRatio: 0.40,
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      icon: Icons.edit,
                      label: 'Editar atividade',
                      backgroundColor: Colors.blue,
                    ),
                  ],
                ),
                child:
                    AtividadeExtracurricularCard(atividade: _atividades[index]),
              );
            },
          );
        }),
      ),
    );
  }
}
