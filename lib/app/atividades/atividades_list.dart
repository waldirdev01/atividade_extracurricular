import 'package:controle_atividade_extracurricular/app/models/app_user.dart';
import 'package:controle_atividade_extracurricular/app/models/atividade_extracurricular.dart';
import 'package:controle_atividade_extracurricular/app/modules/auth/login/login_page.dart';
import 'package:controle_atividade_extracurricular/app/provider/app_user_provider.dart';
import 'package:controle_atividade_extracurricular/app/provider/atividade_extracurricular_provider.dart';
import 'package:controle_atividade_extracurricular/app/widgets/atividade_extracurricular_card.dart';
import 'package:controle_atividade_extracurricular/app/widgets/atividade_extracurricular_create_form.dart';
import 'package:controle_atividade_extracurricular/app/widgets/atividade_extracurricular_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class AtividadesList extends StatelessWidget {
  final String company;
  const AtividadesList({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AppUserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades da $company'),
        actions: [
          user?.type == UserType.admin
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const AtividadeExtracurricularCreateForm(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                )
              : Container(),
          IconButton(
              onPressed: () {
                AppUserProvider().signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.exit_to_app,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<AtividadeExtracurricularProvider>(
            builder: (_, atvidadeExt, child) {
          atvidadeExt.getAtividadesByCompany(company);
          List<AtividadeExtracurricular> _atividades = atvidadeExt.atividades;
          return ListView.builder(
            itemCount: _atividades.length,
            itemBuilder: (context, index) {
              return Slidable(
                startActionPane: user?.type == UserType.admin
                    ? ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                          onPressed: (context) {
                            atvidadeExt.deleteAtividade(_atividades[index]);
                          },
                          icon: Icons.delete,
                          label: 'Delete',
                          backgroundColor: Colors.red,
                        ),
                      ])
                    : null,
                endActionPane: ActionPane(
                  extentRatio: 0.40,
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                AtividadeExtracurricularEditForm(
                              atividadeExtracurricular: _atividades[index],
                            ),
                          ),
                        );
                      },
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
