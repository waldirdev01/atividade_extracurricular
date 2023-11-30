class AtividadeExtracurricular {
  final String? id;
  final DateTime data;
  final String nomeEscola;
  final String nomeAtividade;
  final String local;
  final String turno;
  final String horario;
  final int totalOnibus;
  final int totalAlunos;
  final int totalProfessores;
  final int percursoTotal;
  final String status;

  AtividadeExtracurricular({
    this.id,
    required this.data,
    required this.nomeEscola,
    required this.nomeAtividade,
    required this.local,
    required this.turno,
    required this.horario,
    required this.totalOnibus,
    required this.totalAlunos,
    required this.totalProfessores,
    required this.percursoTotal,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'data':
          data.toIso8601String(), // Converte DateTime para uma string ISO 8601
      'nomeEscola': nomeEscola,
      'nomeAtividade': nomeAtividade,
      'local': local,
      'turno': turno,
      'horario': horario,
      'totalOnibus': totalOnibus,
      'totalAlunos': totalAlunos,
      'totalProfessores': totalProfessores,
      'percursoTotal': percursoTotal,
      'status': status,
    };
  }

  factory AtividadeExtracurricular.fromJson(
      String id, Map<String, dynamic> json) {
    return AtividadeExtracurricular(
      id: id,
      data: DateTime.parse(
          json['data']), // Converte a string ISO 8601 para DateTime
      nomeEscola: json['nomeEscola'],
      nomeAtividade: json['nomeAtividade'],
      local: json['local'],
      turno: json['turno'],
      horario: json['horario'],
      totalOnibus: json['totalOnibus'],
      totalAlunos: json['totalAlunos'],
      totalProfessores: json['totalProfessores'],
      percursoTotal: json['percursoTotal'],
      status: json['status'],
    );
  }
}