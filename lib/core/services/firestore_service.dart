import 'package:SkillUp/core/models/persistence_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService<T extends PersistenceModel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _email => _auth.currentUser?.email ?? 'unknown';

  final T Function(Map<String, dynamic> data, String id) fromMap;
  final String collection;

  FirestoreService({
    required this.collection,
    required this.fromMap,
  });

  FirebaseFirestore get firestore => _firestore;

  Future<void> create(T model) async {
    await _firestore.collection(collection).add({
      ...model.toMap(),
      'createdBy': _email,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<T>> readList() {
    return _firestore
      .collection(collection)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
          .map((doc) => fromMap(doc.data(), doc.id))
          .toList()
      );
  }

  Future<T?> readItem(String id) async {
    final doc = await _firestore.collection(collection).doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return fromMap(doc.data()!, doc.id);
  }

  Future<void> update(String id, T model) async {
    await _firestore.collection(collection).doc(id).update({
      ...model.toMap(),
      'updatedBy': _email,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> delete(String id) async {
    await _firestore.collection(collection).doc(id).delete();
  }
}