abstract class PersistenceModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;

  PersistenceModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
  });

  Map<String, dynamic> toMap();
}