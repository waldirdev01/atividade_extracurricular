import 'package:controle_atividade_extracurricular/app/provider/atividade_extracurricular_provider.dart';
import 'package:flutter/material.dart';

import '../models/atividade_extracurricular.dart';

class AtividadeExtracurricularForm extends StatefulWidget {
  @override
  _AtividadeExtracurricularFormState createState() =>
      _AtividadeExtracurricularFormState();
}

class _AtividadeExtracurricularFormState
    extends State<AtividadeExtracurricularForm> {
  DateTime _selectedDate = DateTime.now();
  AtividadeExtracurricularProvider atividadeExtracurricularProvider =
      AtividadeExtracurricularProvider();
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
      final atividade = AtividadeExtracurricular(
        data: _selectedDate,
        nomeEscola: _nomeEscolaController.text,
        nomeAtividade: _nomeAtividadeController.text,
        local: _localController.text,
        turno: _turnoController.text,
        horario: _horarioController.text,
        totalOnibus: int.parse(_totalOnibusController.text),
        totalAlunos: int.parse(_totalAlunosController.text),
        totalProfessores: int.parse(_totalProfessoresController.text),
        percursoTotal: int.parse(_percursoTotalController.text),
        status: _status,
      );
      await atividadeExtracurricularProvider.addAtividade(atividade);
      Navigator.of(context).pop(atividade);
    }
  }

  final _formKey = GlobalKey<FormState>();

  final _nomeEscolaController = TextEditingController();
  final _nomeAtividadeController = TextEditingController();
  final _localController = TextEditingController();
  final _turnoController = TextEditingController();
  final _horarioController = TextEditingController();
  final _totalOnibusController = TextEditingController();
  final _totalAlunosController = TextEditingController();
  final _totalProfessoresController = TextEditingController();
  final _percursoTotalController = TextEditingController();
  String _status = 'No bloco de assinatura';
  String _turno = 'Matutino';

  @override
  void dispose() {
    _nomeEscolaController.dispose();
    _nomeAtividadeController.dispose();
    _localController.dispose();
    _turnoController.dispose();
    _horarioController.dispose();
    _totalOnibusController.dispose();
    _totalAlunosController.dispose();
    _totalProfessoresController.dispose();
    _percursoTotalController.dispose();
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
                            child: Text(label),
                            value: label,
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
                  items: ['No bloco de assinatura', 'B', 'C', 'D', 'E']
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
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
