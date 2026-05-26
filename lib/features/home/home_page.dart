import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:SkillUp/core/widgets/progress_card.dart';
import 'package:SkillUp/core/widgets/warning_card.dart';
import 'package:SkillUp/core/widgets/card_list_wrapper.dart';
import 'package:SkillUp/features/trilhas/models/list_item.dart';

void toggleSelected(ListItem item) {
  item.isSelected = !item.isSelected;
}
//tasks
final homeTasks = [
  ClassifiedList(
    classifier: "Hoje",
    items: [
      ListItem(
        title: "Estudar Fluxo de Caixa",
        subtitle: "Administração de Empresas",
        date: "20/04/2026",
        isSelected: false,
        onTap: toggleSelected,
      ),

      ListItem(
        title: "Elaborar Plano de Marketing",
        subtitle: "Marketing",
        date: "23/04/2026",
        isSelected: false,
        onTap: toggleSelected,
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