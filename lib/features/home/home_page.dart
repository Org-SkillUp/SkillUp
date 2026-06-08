import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:flutter/material.dart';
import 'package:SkillUp/core/widgets/progress_card.dart';
import 'package:SkillUp/core/widgets/warning_card.dart';
import 'package:SkillUp/core/widgets/card_list_wrapper.dart';
import 'package:SkillUp/core/widgets/header_card.dart';
import 'package:SkillUp/features/trilhas/models/list.dart';

void toggleSelected(TarefaDetail item) {
  item.dataConclusao = item.dataConclusao == null ? DateTime.parse("2026-04-20") : null;
}
//tasks
final homeTasks = [
  ClassifiedList(
    classifier: "Hoje",
    items: [
      TarefaDetail(
        titulo: "Estudar Fluxo de Caixa",
        trilhaId: "administracao-empresas",
        dataInicio: DateTime.parse("2026-04-18"),
        dataPrazo: DateTime.parse("2026-04-20"),
        dataConclusao: null,
        metaRelacionada: "Prova administração financeira",
        descricao: "Leitura do material didático sobre gestão de tesouraria e resolução dos 5 exercícios práticos de projeção financeira da Unidade 2. Prazo final para envio do relatório de progresso: 20/04/2026.",
      ),

      TarefaDetail(
        titulo: "Elaborar Plano de Marketing",
        trilhaId: "marketing",
        dataInicio: DateTime.parse("2026-04-23"),
        dataPrazo: DateTime.parse("2026-04-23"),
        dataConclusao: null,
        metaRelacionada: "Prova marketing",
        descricao: "Elaboração do plano de marketing para o próximo trimestre. Prazo final para envio do relatório de progresso: 23/04/2026.",
      ),
    ],
  ),
];

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // Header
              HomeHeader(
                userName: userName,
              ),

              const SizedBox(height: 24),
              
              // Card de Progressão
              const ProgressCard(),

              const SizedBox(height: 20),

              // Avisos
              const Text(
                "Avisos",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const WarningBanner(),

              const SizedBox(height: 24),

              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  children: [
                    CardListWrapper(
                      title: "Tarefas Próximas",
                      subtitle: "Tarefas com prazo nos próximos dias",
                      onExpand: () => {},
                      items: homeTasks,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BotAppBar(
        selectedPage: AuthRoutes.home
      )
    );
  }
}