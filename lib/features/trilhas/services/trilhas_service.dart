import 'package:SkillUp/core/services/firestore_service.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrilhasService extends FirestoreService<Trilha> {
  TrilhasService() : super(
    collection: 'trilhas',
    fromMap: Trilha.fromMap,
  );

  Future<void> updateStatus(String id, TrilhaStatus status) async {
    await firestore.collection(collection).doc(id).update({
      'status': status.name,
      'updatedBy': FirebaseAuth.instance.currentUser?.email ?? 'unknown',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Trilha>> readListByUser(String email) {
    return firestore
      .collection(collection)
      .where('createdBy', isEqualTo: email)
      .snapshots()
      .map((s) => s.docs.map((d) => fromMap(d.data(), d.id)).toList());
  }
}