import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_atividade_extracurricular/app/models/atividade_extracurricular.dart';
import 'package:flutter/material.dart';

class AtividadeExtracurricularProvider extends ChangeNotifier {
  List<AtividadeExtracurricular> atividades = [];
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference atividadesRef;

  AtividadeExtracurricularProvider() {
    atividadesRef = _db.collection('atividades');
  }

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
    notifyListeners();
  }

  Future<List<AtividadeExtracurricular>> getAtividades() async {
    atividadesRef = _db.collection('atividades');
    final querySnapshot = await atividadesRef.get();
    atividades = querySnapshot.docs
        .map((doc) => AtividadeExtracurricular.fromJson(
            doc.id, doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
    return atividades;
  }
}
