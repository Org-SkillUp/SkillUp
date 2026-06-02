import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/theme/status_theme.dart';
import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/card_list_wrapper.dart';
import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:SkillUp/core/widgets/indicator.dart';
import 'package:SkillUp/core/widgets/quantity_indicator.dart';
import 'package:SkillUp/core/widgets/selectable_title.dart';
import 'package:SkillUp/core/widgets/state_button.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/trilhas/models/list.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:SkillUp/features/trilhas/services/trilhas_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrilhasPage extends StatefulWidget {
  const TrilhasPage({super.key});

  @override
  State<TrilhasPage> createState() => _TrilhasPageState();
}

class _TrilhasPageState extends State<TrilhasPage> {
  final _service = TrilhasService();

  final String _userEmail = FirebaseAuth.instance.currentUser?.email ?? 'unknown';

  List<Trilha> _trilhas = [];
  Trilha? _selected;

  bool _isCreating = false;
  final _trilhaNomeController = TextEditingController();

  @override
  void dispose() {
    _trilhaNomeController.dispose();
    super.dispose();
  }

  int get _totalTasks => _selected?.tarefas.fold(0, (sum, cl) => sum! + cl.items.length) ?? 0;

  int get _finishedTasks => _selected?.tarefas.fold(
    0, (sum, cl) => sum! + cl.items.where((i) => i.isSelected).length,
  ) ?? 0;

  String get _progressLabel => '$_finishedTasks de $_totalTasks tarefas concluídas';

  String get _progressValue => _totalTasks == 0
    ? '0%'
    : '${((_finishedTasks / _totalTasks) * 100).round()}%';

  String get _startDate {
    final d = _selected?.startedAt;
    if (d == null) return '—';
    return '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/'
      '${d.year}';
  }

  void _onTrilhaChanged(String? newId) {
    if (newId == null) return;
    setState(() {
      _selected = _trilhas.firstWhere(
        (t) => t.id == newId,
        orElse: () => _selected!,
      );
    });
  }

  Future<void> _togglePause() async {
    if (_selected == null) return;

    final novoStatus = _selected!.status == TrilhaStatus.paused
        ? TrilhaStatus.active
        : TrilhaStatus.paused;

    setState(() {
      _selected = _selected!.copyWith(status: novoStatus);
      final idx = _trilhas.indexWhere((t) => t.id == _selected!.id);
      if (idx != -1) _trilhas[idx] = _selected!;
    });

    await _service.updateStatus(_selected!.id!, novoStatus);
  }

  void _onTaskToggle(ListItem item) {
    setState(() => item.isSelected = !item.isSelected);
    // TODO: persistir alteração de tarefa no Firestore quando modelo estiver pronto
  }

  Color getStatusColor(BuildContext context) {
    final nav = Theme.of(context).extension<StatusTheme>()!;

    return switch (_selected?.status) {
      TrilhaStatus.active => nav.activeColor,
      TrilhaStatus.paused => nav.pausedColor,
      TrilhaStatus.completed => nav.completedColor,
      TrilhaStatus.canceled => nav.canceledColor,
      TrilhaStatus.pending => nav.pendingColor,
      null => Colors.cyanAccent,
    };
  }

  @override
  Widget build(BuildContext context) {
    final stButton = Theme.of(context).extension<StateButtonTheme>()!;

    return StreamBuilder<List<Trilha>>(
      stream: _service.readListByUser(_userEmail),
      builder: (context, snapshot) {
        final trilhas = snapshot.data ?? [];

        if (snapshot.hasError) {
          return Scaffold(
            appBar: TopAppBar(),
            body: Center(
              child: Text('Erro ao carregar trilhas: ${snapshot.error}'),
            ),
            bottomNavigationBar: BotAppBar(selectedPage: AuthRoutes.trilhas),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (trilhas.isEmpty) {
          return Scaffold(
            appBar: TopAppBar(),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_isCreating) ...[
                    TextFieldBuilder.buildTextField(
                      hint: "Nome da Trilha",
                      fillColor: Colors.white,
                      controller: _trilhaNomeController,
                    ),

                    const SizedBox(height: 12),

                    StateButton(
                      onPressed: () async {
                        final name = _trilhaNomeController.text.trim();
                        if (name.isEmpty) return;

                        await _service.create(Trilha(
                          title: name,
                          subtitle: "",
                          duedate: DateTime.now(),
                        ));

                        setState(() {
                          _isCreating = false;
                          _trilhaNomeController.clear();
                        });
                      },
                      label: Text('CONFIRMAR'),
                      bgColor: stButton.plainBackgroundColor,
                      borderRadius: 16,
                    ),

                    const SizedBox(height: 16),
                  ],

                  Center(
                    child: StateButton(
                      onPressed: () {
                        setState(() => _isCreating = true);
                      },
                      label: Text(
                        'NOVA TRILHA',
                        style: TextStyle(
                          color: stButton.plainLabelColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arimo',
                          fontSize: 16,
                        ),
                      ),
                      bgColor: stButton.plainBackgroundColor,
                      borderRadius: 16,
                      icon: Icon(Icons.add, color: stButton.plainLabelColor),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BotAppBar(selectedPage: AuthRoutes.trilhas),
          );
        }

        final selected = trilhas.any((t) => t.id == _selected?.id)
            ? trilhas.firstWhere((t) => t.id == _selected!.id)
            : trilhas.first;

        if (_selected?.id != selected.id) {
          _selected = selected;
        }

        print(selected.title);
        final isPaused = selected.status == TrilhaStatus.paused;

        return Scaffold(
          appBar: TopAppBar(),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                Row(
                  children: [
                    Expanded(
                      child: SelectableTitle(
                        label: 'Trilha Selecionada',
                        selectedLabel: selected.title,
                        underLabel: _progressLabel,
                        options: Map.fromEntries(
                          trilhas.map(
                            (t) => MapEntry(t.id!, t.title),
                          )
                        ),
                        selected: selected.id!,
                        onChanged: _onTrilhaChanged,
                      ),
                    ),
                    const SizedBox(width: 28),
                    QuantityIndicator(value: _progressValue),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Indicator(
                        icon: Icons.calendar_today_outlined,
                        label: 'Início',
                        value: _startDate,
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Indicator(
                        icon: Icons.circle,
                        label: 'Status',
                        value: selected.status.label,
                        dotColor: getStatusColor(context),
                        valueColor: getStatusColor(context),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Column(
                  children: [
                    StateButton(
                      onPressed: _togglePause,
                      label: Text(
                        isPaused ? 'RETOMAR' : 'PAUSAR',
                        style: TextStyle(
                          color: stButton.outlinedYellowHighlighColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arimo',
                          fontSize: 16,
                        ),
                      ),
                      bgColor: stButton.outlinedBackgroundColor,
                      borderColor: stButton.outlinedYellowHighlighColor,
                      borderRadius: 14,
                    ),
                    const SizedBox(height: 16),

                    if (_isCreating) ...[
                      TextFieldBuilder.buildTextField(
                        hint: "Nome da Trilha",
                        fillColor: const Color.fromARGB(255, 78, 73, 73),
                        controller: _trilhaNomeController,
                      ),

                      const SizedBox(height: 12),

                      StateButton(
                        onPressed: () async {
                          final name = _trilhaNomeController.text.trim();
                          if (name.isEmpty) return;

                          await _service.create(Trilha(
                            title: name,
                            subtitle: "",
                            duedate: DateTime.now(),
                          ));

                          setState(() {
                            _isCreating = false;
                            _trilhaNomeController.clear();
                          });
                        },
                        label: Text('CONFIRMAR'),
                        bgColor: stButton.plainBackgroundColor,
                        borderRadius: 16,
                      ),

                      const SizedBox(height: 16),
                    ],

                    StateButton(
                      onPressed: () {
                        setState(() => _isCreating = true);
                      },
                      label: Text(
                        'NOVA TRILHA',
                        style: TextStyle(
                          color: stButton.plainLabelColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arimo',
                          fontSize: 16,
                        ),
                      ),
                      bgColor: stButton.plainBackgroundColor,
                      borderRadius: 16,
                      icon: Icon(Icons.add, color: stButton.plainLabelColor),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                CardListWrapper(
                  title: 'TAREFAS',
                  items: selected.tarefas,
                  onAdd: () {
                    // TODO: implementar criação de tarefa
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BotAppBar(selectedPage: AuthRoutes.trilhas),
        );
      },
    );
  }
}