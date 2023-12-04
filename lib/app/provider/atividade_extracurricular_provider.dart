import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_atividade_extracurricular/app/models/atividade_extracurricular.dart';
import 'package:flutter/material.dart';

class AtividadeExtracurricularProvider extends ChangeNotifier {
  List<AtividadeExtracurricular> atividades = [];
  AtividadeExtracurricular? atividade;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference atividadesRef;

  Future<void> addAtividade(AtividadeExtracurricular atividade) async {
    atividadesRef = _db.collection('atividades');
    await atividadesRef.add(atividade.toJson());
    notifyListeners();
  }

  Future<void> updateAtividade(AtividadeExtracurricular atividade) async {
    atividadesRef = _db.collection('atividades');
    await atividadesRef.doc(atividade.id).update(atividade.toJson());
    notifyListeners();
  }

  Future<void> deleteAtividade(AtividadeExtracurricular atividade) async {
    atividadesRef = _db.collection('atividades');
    await atividadesRef.doc(atividade.id).delete();
    atividades.removeWhere((element) => element.id == atividade.id);
    notifyListeners();
  }

  Future<void> getAtividades() async {
    atividadesRef = _db.collection('atividades');
    final querySnapshot = await atividadesRef.get();
    atividades = querySnapshot.docs
        .map((doc) => AtividadeExtracurricular.fromJson(
            doc.id, doc.data() as Map<String, dynamic>))
        .toList();
    atividades.sort((a, b) => a.data.compareTo(b.data));
    notifyListeners();
  }

  Future<void> getAtividade(String id) async {
    atividadesRef = _db.collection('atividades');
    final querySnapshot = await atividadesRef.doc(id).get();
    atividade = AtividadeExtracurricular.fromJson(
        querySnapshot.id, querySnapshot.data() as Map<String, dynamic>);

    notifyListeners();
  }

  Future<void> getAtividadesByCompany(String company) async {
    atividadesRef = _db.collection('atividades');
    final querySnapshot = await atividadesRef
        .where('company', isEqualTo: company)
        .get()
        .catchError((e) =>
            // ignore: invalid_return_type_for_catch_error
            ScaffoldMessenger(child: SnackBar(content: Text(e.toString()))));
    atividades = querySnapshot.docs
        .map((doc) => AtividadeExtracurricular.fromJson(
            doc.id, doc.data() as Map<String, dynamic>))
        .toList();
    atividades.sort((a, b) => a.data.compareTo(b.data));
    notifyListeners();
  }
}
