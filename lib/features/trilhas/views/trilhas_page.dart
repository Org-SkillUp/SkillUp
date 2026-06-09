import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/card_list_wrapper.dart';
import 'package:SkillUp/core/widgets/quantity_indicator.dart';
import 'package:SkillUp/core/widgets/selectable_title.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/tarefas/routes/tarefas_navigation.dart';
import 'package:SkillUp/features/trilhas/models/trilha.dart';
import 'package:SkillUp/features/trilhas/viewmodels/trilha_view_model.dart';
import 'package:SkillUp/features/trilhas/views/blank_trilhas_view.dart';
import 'package:SkillUp/features/trilhas/widgets/info_panel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrilhasPage extends StatefulWidget {
  const TrilhasPage({
    super.key,
    this.selected
  });

  final String? selected;

  @override
  State<TrilhasPage> createState() => _TrilhasPageState();
}

class _TrilhasPageState extends State<TrilhasPage> {
  late final TrilhasViewModel _vm;
  final _trilhaNomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final email = FirebaseAuth.instance.currentUser?.email ?? 'unknown';
    _vm = TrilhasViewModel(userEmail: email);
    _vm.setNavigationCallback(
      (tarefa) => TarefasNavigation.goToDetalhe(context, tarefa),
    );
  }

  @override
  void dispose() {
    _trilhaNomeController.dispose();
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Trilha>>(
      stream: _vm.trilhasStream,
      builder: (context, snapshot) {
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

        final trilhas = snapshot.data ?? [];

        if (trilhas.isEmpty) {
          return BlankTrilhasView(
            onCreateTrilha: (trilha) => _vm.createTrilhaModel(trilha),
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _vm.onStreamData(trilhas);
        });

        return ListenableBuilder(
          listenable: _vm,
          builder: (context, _) => _buildContent(context),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final selected = _vm.selected;

    if (selected == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                    underLabel: _vm.progressLabel,
                    options: Map.fromEntries(
                      _vm.trilhas.map((t) => MapEntry(t.id!, t.title)),
                    ),
                    selected: selected.id!,
                    onChanged: _vm.selectTrilha,
                  ),
                ),
                const SizedBox(width: 28),
                QuantityIndicator(value: _vm.progressValue),
              ],
            ),

            const SizedBox(height: 16),

            InfoPanel(
              selected: selected,
              vm: _vm,
              trilhaNomeController: _trilhaNomeController,
            ),

            const SizedBox(height: 20),

            CardListWrapper(
              title: 'TAREFAS',
              items: selected.tarefas,
              onAdd: () => TarefasNavigation.goToCriarTarefa(context, trilhaId: selected.id),
            ),

            if (selected.tarefas.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Nenhuma tarefa cadastrada ainda.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Arimo',
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BotAppBar(selectedPage: AuthRoutes.trilhas),
    );
  }
}