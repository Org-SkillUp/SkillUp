import 'package:cloud_firestore/cloud_firestore.dart';

/// Campos de auditoria compartilhados por entidades persistidas no Firestore.
///
/// O [FirestoreService] grava `createdBy`, `createdAt` e `updatedAt` na
/// criação, e `updatedBy` + `updatedAt` na atualização — junto com o
/// retorno de [toMap] de cada modelo concreto.
abstract class PersistenceModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;

  const PersistenceModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  /// Dados de negócio do documento (sem metadados de auditoria).
  Map<String, dynamic> toMap();

  /// Converte valores vindos do Firestore (`Timestamp` ou `DateTime`).
  static DateTime? parseTimestamp(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}