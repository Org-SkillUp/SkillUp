import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/progress_card.dart';
import 'package:SkillUp/core/widgets/warning_card.dart';
import 'package:SkillUp/core/widgets/card_list_wrapper.dart';
import 'package:SkillUp/core/widgets/header_card.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/tarefas/models/list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({
    super.key,
    required this.userName,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ClassifiedList> homeTasks;

  int trilhasConcluidas = 0;
  int totalTrilhas = 0;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _toggleSelected(ListItem item) {
    setState(() {
      item.isSelected = !item.isSelected;
    });
  }

  void _loadTasks() {
    totalTrilhas = 5;
    trilhasConcluidas = 2;

    homeTasks = [
      ClassifiedList(
        classifier: "Hoje",
        items: [
          ListItem(
            title: "Estudar Fluxo de Caixa",
            subtitle: "Administração de Empresas",
            date: DateTime(2026, 4, 20),
            isSelected: false,
            onTap: _toggleSelected,
          ),
          ListItem(
            title: "Elaborar Plano de Marketing",
            subtitle: "Marketing",
            date: DateTime(2026, 4, 23),
            isSelected: false,
            onTap: _toggleSelected,
          ),
        ],
      ),
    ];
  }

  Widget _buildWarningsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Avisos",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        WarningBanner(
          tarefasHoje: 3, 
        ),
      ],
    );
  }

  Widget _buildTasksSection() {
    return Expanded(
      child: ListView(
        children: [
          CardListWrapper(
            title: "Tarefas Próximas",
            subtitle: "Tarefas com prazo nos próximos dias",
            onExpand: () {},
            items: homeTasks,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(userName: widget.userName),
              const SizedBox(height: 24),
              ProgressCard(
                trilhasConcluidas: trilhasConcluidas,
                totalTrilhas: totalTrilhas,
              ),
              const SizedBox(height: 20),
              _buildWarningsSection(),
              const SizedBox(height: 24),
              _buildTasksSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BotAppBar(
        selectedPage: AuthRoutes.home,
      ),
    );
  }
}