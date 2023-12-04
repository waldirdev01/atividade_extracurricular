// ignore_for_file: library_private_types_in_public_api

import 'package:controle_atividade_extracurricular/app/models/app_user.dart';
import 'package:controle_atividade_extracurricular/app/modules/pollo/atividades_list.dart';
import 'package:controle_atividade_extracurricular/app/provider/atividade_extracurricular_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/atividade_extracurricular.dart';
import '../provider/app_user_provider.dart';

class AtividadeExtracurricularCreateForm extends StatefulWidget {
  const AtividadeExtracurricularCreateForm({super.key});

  @override
  _AtividadeExtracurricularCreateFormState createState() =>
      _AtividadeExtracurricularCreateFormState();
}

class _AtividadeExtracurricularCreateFormState
    extends State<AtividadeExtracurricularCreateForm> {
  final _formKey = GlobalKey<FormState>();

  final _nomeEscolaController = TextEditingController();
  final _nomeAtividadeController = TextEditingController();
  final _localController = TextEditingController();
  final _horarioController = TextEditingController();
  final _totalOnibusController = TextEditingController();
  final _totalAlunosController = TextEditingController();
  final _totalProfessoresController = TextEditingController();
  final _percursoTotalController = TextEditingController();
  final _studentsController = TextEditingController();
  final _statusController = TextEditingController();
  String _status = 'Aguardando Diego';
  String _turno = 'Matutino';
  String _company = 'POLLO';
  List<String> studentList = [];
  late AppUser appUser;
  DateTime _selectedDate = DateTime.now();
  AtividadeExtracurricularProvider atividadeExtracurricularProvider =
      AtividadeExtracurricularProvider();
  void _getCurrentUser() async {
    final provider = Provider.of<AppUserProvider>(context, listen: false);
    final currentUser = await provider.getCurrentUser();
    if (currentUser != null) {
      setState(() {
        appUser = currentUser;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      studentList = _studentsController.text
          .split(',')
          .map((student) => student.trim())
          .where((student) => student.isNotEmpty)
          .toList();
      final atividade = AtividadeExtracurricular(
          company: _company,
          data: _selectedDate,
          nomeEscola: _nomeEscolaController.text,
          nomeAtividade: _nomeAtividadeController.text,
          local: _localController.text,
          turno: _turno,
          horario: _horarioController.text,
          totalOnibus: int.parse(_totalOnibusController.text),
          totalAlunos: int.parse(_totalAlunosController.text),
          totalProfessores: int.parse(_totalProfessoresController.text),
          percursoTotal: int.parse(_percursoTotalController.text),
          status:
              _statusController.text.isEmpty ? _status : _statusController.text,
          userMail: appUser.email,
          students: studentList);
      await atividadeExtracurricularProvider.addAtividade(atividade);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => AtividadesList(
                    company: _company,
                  )),
          (route) => false);
    }
  }

  @override
  void dispose() {
    _nomeEscolaController.dispose();
    _nomeAtividadeController.dispose();
    _localController.dispose();
    _horarioController.dispose();
    _totalOnibusController.dispose();
    _totalAlunosController.dispose();
    _totalProfessoresController.dispose();
    _percursoTotalController.dispose();
    _studentsController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Atividade Extracurricular'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text(
                      'Data do evento: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _company,
                  decoration: const InputDecoration(
                      labelText: 'Empresa',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  items: ['POLLO', 'TRANSFER']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _company = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nomeEscolaController,
                  decoration: const InputDecoration(
                      labelText: 'Nome da Escola',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o nome da escola';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nomeAtividadeController,
                  decoration: const InputDecoration(
                      labelText: 'Nome da Atividade',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o nome da atividade';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _localController,
                  decoration: const InputDecoration(
                      labelText: 'Local',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o local';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _turno,
                  decoration: const InputDecoration(
                      labelText: 'Turno',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  items: ['Matutino', 'Vespertino']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _turno = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _horarioController,
                  decoration: const InputDecoration(
                      labelText: 'Horário',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o horário';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _totalOnibusController,
                  decoration: const InputDecoration(
                      labelText: 'Total de Ônibus',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o total de ônibus';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _totalAlunosController,
                  decoration: const InputDecoration(
                      labelText: 'Total de Alunos',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o total de alunos';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _totalProfessoresController,
                  decoration: const InputDecoration(
                      labelText: 'Total de Professores',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o total de professores';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _percursoTotalController,
                  decoration: const InputDecoration(
                      labelText: 'Percurso Total',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o percurso total';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor, insira um número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  items: [
                    'Aguardando Diego',
                    'No bloco de assinatura',
                    'GCOTE',
                    'TCB',
                  ]
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                _status == 'TCB'
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: _statusController,
                          decoration: const InputDecoration(
                              labelText: 'Código da TCB',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o código';
                            }
                            return null;
                          },
                        ),
                      )
                    : const SizedBox(
                        height: 8,
                      ),
                TextFormField(
                  controller: _studentsController,
                  decoration: const InputDecoration(
                    labelText: 'Lista de Estudantes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  keyboardType: TextInputType
                      .multiline, // Permite entrada de texto em múltiplas linhas
                  maxLines:
                      null, // Define o número máximo de linhas para infinito
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a lista de estudantes';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Salvar',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
