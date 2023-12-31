import 'package:controle_atividade_extracurricular/app/modules/auth/login/login_page.dart';
import 'package:controle_atividade_extracurricular/app/modules/pollo/atividades_list.dart';
import 'package:controle_atividade_extracurricular/app/widgets/company_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CompanyCard(
              companyName: 'POLLO',
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const AtividadesList(
                              company: 'POLLO',
                            )),
                  )),
          const SizedBox(
            width: 20,
          ),
          CompanyCard(
              companyName: 'TRANSFER',
              onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const AtividadesList(
                              company: 'TRANSFER',
                            )),
                  )),
        ],
      )),
    );
  }
}
