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

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _toggleSelected(ListItem item) {
    item.isSelected = !item.isSelected;
  }

  void _loadTasks() {
    homeTasks = [
      ClassifiedList(
        classifier: "Hoje",
        items: [],
      ),
    ];
  }

  Widget _buildWarningsSection() {
    return const Column(
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
        WarningBanner(),
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
      appBar: AppBar(
        title: const Text('SkillUp'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(userName: widget.userName),
              const SizedBox(height: 24),
              const ProgressCard(),
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