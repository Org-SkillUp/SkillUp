import 'package:SkillUp/features/tarefas/models/list.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:SkillUp/features/trilhas/services/trilhas_service.dart';
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

  List<Trilha> get trilhas => _trilhas;
  bool get isCreating => _isCreating;
  bool get isPaused => _selected?.status == TrilhaStatus.paused;

  Stream<List<Trilha>> get trilhasStream => _service.readListByUser(userEmail);

  Trilha? get selected {
    if (_selected == null) return null;
    return _selected!.copyWith(
      tarefas: _selected!.tarefas.map((lista) => ClassifiedList(
        classifier: lista.classifier,
        items: lista.items.map((item) {
          if (item is TarefaDetail && _onOpenTarefa != null) {
            return item.copyWith(onOpen: () => _onOpenTarefa!(item));
          }
          return item;
        }).toList(),
      )).toList(),
    );
  }

  void setNavigationCallback(void Function(TarefaDetail) callback) {
    _onOpenTarefa = callback;
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

  String get startDate {
    final d = _selected?.startedAt;
    if (d == null) return '—';
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }

  String get dueDate {
    final d = _selected?.duedate;
    if (d == null) return '—';
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }

  String get finishDate {
    final d = _selected?.finishedAt;
    if (d == null) return '—';
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }

  void onStreamData(List<Trilha> trilhas) {
    _trilhas = trilhas;
    final stillExists = trilhas.any((t) => t.id == _selected?.id);
    _selected = stillExists
        ? trilhas.firstWhere((t) => t.id == _selected!.id)
        : trilhas.firstOrNull;
    notifyListeners();
  }

  void selectTrilha(String id) {
    _selected = _trilhas.firstWhere(
      (t) => t.id == id,
      orElse: () => _selected!,
    );
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
        ? DateTime.now()
        : _selected!.startedAt;

    final finishedAt = novoStatus == TrilhaStatus.completed && _selected!.finishedAt == null
        ? DateTime.now()
        : _selected!.finishedAt;

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
    final idx = _trilhas.indexWhere((t) => t.id == _selected!.id);
    if (idx != -1) _trilhas[idx] = _selected!;
    notifyListeners();
  }
}