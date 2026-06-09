import 'package:SkillUp/features/tarefas/models/list.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:SkillUp/features/trilhas/services/trilhas_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrilhasViewModel extends ChangeNotifier {
  final TrilhasService _service;
  final String userEmail;

  TrilhasViewModel({required this.userEmail, TrilhasService? service})
    : _service = service ?? TrilhasService();

  List<Trilha> _trilhas = [];
  Trilha? _selected;
  bool _isCreating = false;
  void Function(TarefaDetail)? _onOpenTarefa;

  Trilha? _selectedCache;
  Trilha? _selectedRaw;

  List<Trilha> get trilhas => _trilhas;
  bool get isCreating => _isCreating;
  bool get isPaused => _selected?.status == TrilhaStatus.paused;
  Stream<List<Trilha>> get trilhasStream => _service.readListByUser(userEmail);

  Trilha? get selected {
    if (_selected == null) return null;

    if (identical(_selectedRaw, _selected) && _selectedCache != null) {
      return _selectedCache;
    }

    _selectedRaw = _selected;
    _selectedCache = _buildSelectedWithCallbacks(_selected!);
    return _selectedCache;
  }

  Trilha _buildSelectedWithCallbacks(Trilha trilha) {
    return trilha.copyWith(
      tarefas: trilha.tarefas.map((lista) => ClassifiedList(
        classifier: lista.classifier,
        items: lista.items.map((item) {
          if (item is TarefaDetail) {
            final taskId = item.id;
            return item.copyWith(
              onOpen: _onOpenTarefa != null ? () => _onOpenTarefa!(item) : null,
              onTap: () => _toggleTaskById(taskId, item.concluida),
            );
          }
          return item;
        }).toList(),
      )).toList(),
    );
  }

  void setNavigationCallback(void Function(TarefaDetail) callback) {
    _onOpenTarefa = callback;
    // invalida o cache para reinjetar o novo callback
    _selectedCache = null;
    _selectedRaw = null;
  }

  // toggle por id — não depende da instância capturada pelo closure
  Future<void> _toggleTaskById(String? taskId, bool atualConcluida) async {
    if (taskId == null || _selected == null) return;

    final novaConcluida = !atualConcluida;
    final novaDataConclusao = novaConcluida ? DateTime.now() : null;

    _selected = _selected!.copyWith(
      tarefas: _selected!.tarefas.map((lista) => ClassifiedList(
        classifier: lista.classifier,
        items: lista.items.map((item) {
          if (item is TarefaDetail && item.id == taskId) {
            return item.copyWith(
              concluida: novaConcluida,
              dataConclusao: novaDataConclusao,
            );
          }
          return item;
        }).toList(),
      )).toList(),
    );

    _sync();

    await _service.updateTarefa(taskId, {
      'concluida': novaConcluida,
      'dataConclusao': novaDataConclusao != null
          ? Timestamp.fromDate(novaDataConclusao)
          : null,
      'updatedAt': FieldValue.serverTimestamp(),
      'updatedBy': FirebaseAuth.instance.currentUser?.email,
    });
  }

  int get totalTasks =>
    _selected?.tarefas.fold(0, (sum, cl) => sum! + cl.items.length) ?? 0;

  int get finishedTasks =>
    _selected?.tarefas.fold(
      0,
      (sum, cl) => sum! + cl.items.where((i) => i.isSelected).length,
    ) ?? 0;

  String get progressLabel => '$finishedTasks de $totalTasks tarefas concluídas';

  String get progressValue => totalTasks == 0
      ? '0%'
      : '${((finishedTasks / totalTasks) * 100).round()}%';

  void onStreamData(List<Trilha> trilhas) {
    _trilhas = List.of(trilhas);
    final stillExists = _trilhas.any((t) => t.id == _selected?.id);
    _selected = stillExists
        ? _trilhas.firstWhere((t) => t.id == _selected!.id)
        : _trilhas.firstOrNull;

    _selectedCache = null;
    _selectedRaw = null;

    notifyListeners();
  }

  void selectTrilha(String id) {
    _selected = _trilhas.firstWhere(
      (t) => t.id == id,
      orElse: () => _selected!,
    );
    _selectedCache = null;
    _selectedRaw = null;
    notifyListeners();
  }

  void setCreating(bool value) {
    _isCreating = value;
    notifyListeners();
  }

  Future<void> createTrilhaModel(Trilha trilha) => _service.create(trilha);

  Future<void> createTrilha(String name) async {
    if (name.trim().isEmpty) return;
    await _service.create(Trilha(title: name.trim()));
    _isCreating = false;
    notifyListeners();
  }

  Future<void> createTarefa(String titulo) async {
    if (_selected == null || titulo.trim().isEmpty) return;
    await _service.createTarefa(TarefaDetail(
      titulo: titulo.trim(),
      trilhaId: _selected!.id!,
    ));
  }

  Future<void> deleteTrilha(String id) => _service.delete(id);

  Future<void> togglePause() async {
    if (_selected == null) return;
    final novoStatus = isPaused ? TrilhaStatus.active : TrilhaStatus.paused;
    _selected = _selected!.copyWith(status: novoStatus);
    _sync();
    await _service.updateStatus(_selected!.id!, novoStatus);
  }

  Future<void> updateStartDate(DateTime date) async {
    if (_selected == null) return;
    _selected = _selected!.copyWith(startedAt: date);
    _sync();
    await _service.updateDateField(_selected!.id!, 'startedAt', date);
  }

  Future<void> updateDueDate(DateTime date) async {
    if (_selected == null) return;
    _selected = _selected!.copyWith(duedate: date);
    _sync();
    await _service.updateDateField(_selected!.id!, 'duedate', date);
  }

  Future<void> updateFinishDate(DateTime date) async {
    if (_selected == null) return;
    _selected = _selected!.copyWith(finishedAt: date);
    _sync();
    await _service.updateDateField(_selected!.id!, 'finishedAt', date);
  }

  Future<void> updateStatus(TrilhaStatus novoStatus) async {
    if (_selected == null) return;

    final startedAt = novoStatus == TrilhaStatus.active && _selected!.startedAt == null
        ? DateTime.now() : _selected!.startedAt;

    final finishedAt = novoStatus == TrilhaStatus.completed && _selected!.finishedAt == null
        ? DateTime.now() : _selected!.finishedAt;

    _selected = _selected!.copyWith(
      status: novoStatus,
      startedAt: startedAt,
      finishedAt: finishedAt,
    );
    _sync();

    await _service.updateStatus(_selected!.id!, novoStatus);
    if (startedAt != null) await _service.updateDateField(_selected!.id!, 'startedAt', startedAt);
    if (finishedAt != null) await _service.updateDateField(_selected!.id!, 'finishedAt', finishedAt);
  }

  void _sync() {
    _trilhas = [
      for (final t in _trilhas)
        if (t.id == _selected!.id) _selected! else t,
    ];
    _selectedCache = null;
    _selectedRaw = null;
    notifyListeners();
  }
}