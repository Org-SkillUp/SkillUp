import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/card_item.dart';
import 'package:SkillUp/core/widgets/indicator.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:SkillUp/features/auth/routes/auth_routes.dart';
import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _skills = [
  _SkillInfo(
    title: 'Gestão Financeira',
    goal: 'Simular orçamento de uma empresa',
    date: '15/03/2026',
  ),
  _SkillInfo(
    title: 'Planejamento Estratégico',
    goal: 'Criar plano estratégico simples',
    date: '16/03/2026',
  ),
  _SkillInfo(
    title: 'Gestão de Operações',
    goal: 'Mapear um processo simples',
    date: '17/03/2026',
  ),
];

class ContaPage extends StatelessWidget {
  const ContaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final stateButton = Theme.of(context).extension<StateButtonTheme>()!;
    final muted = colorScheme.primary.withAlpha((255 * 0.64).round());

    return Scaffold(
      appBar: const TopAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conta',
                        style: textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Informações do usuário',
                        style: textTheme.bodyMedium?.copyWith(
                          color: muted,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: stateButton.outlinedRedHighlighColor,
                    side: BorderSide(
                      color: stateButton.outlinedRedHighlighColor,
                      width: 1.8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'DESATIVAR CONTA',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pedro Simões',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Ativo desde',
                    style: textTheme.labelMedium?.copyWith(
                      color: muted,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '20 de março de 2026',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Indicator(
                    iconPath: 'assets/icons/goal_icon.svg',
                    iconColor: Color(0xFF3BD3AC),
                    iconBackgroundColor: Color(0x333BD3AC),
                    iconInValueRow: true,
                    label: 'Trilhas Ativas',
                    value: '5',
                    height: 96,
                    width: 112,
                    padding: EdgeInsets.all(14),
                    borderRadius: 12,
                    labelFontSize: 12,
                    valueFontSize: 22,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Indicator(
                    icon: Icons.flag_outlined,
                    iconColor: Color(0xFFB7C430),
                    iconBackgroundColor: Color(0x33B7C430),
                    iconInValueRow: true,
                    label: 'Metas Criadas',
                    value: '5',
                    height: 96,
                    width: 112,
                    padding: EdgeInsets.all(14),
                    borderRadius: 12,
                    labelFontSize: 12,
                    valueFontSize: 22,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Indicator(
                    icon: Icons.workspace_premium_outlined,
                    iconColor: Color(0xFF59E66D),
                    iconBackgroundColor: Color(0x3359E66D),
                    iconInValueRow: true,
                    label: 'Habilidades',
                    value: '5',
                    height: 96,
                    width: 112,
                    padding: EdgeInsets.all(14),
                    borderRadius: 12,
                    labelFontSize: 12,
                    valueFontSize: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 54),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Minhas Habilidades',
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/arrow_down_icon.svg',
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(muted, BlendMode.srcIn),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ..._skills.map(
                    (skill) => CardItem(
                      // TODO: atualizar para buscar tarefas no banco
                      item: TarefaDetail(titulo: skill.title, trilhaId: "temp"),
                      backgroundColor: Colors.transparent,
                      borderRadius: 0,
                      disableSelectedStyle: true,
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.only(left: 10, bottom: 14),
                      showBottomDate: false,
                      showCheckbox: false,
                      sideColor: const Color(0xFF59E66D),
                      sideWidth: 2,
                      trailing: Text(
                        skill.date,
                        style: textTheme.labelSmall?.copyWith(
                          color: muted.withAlpha((255 * 0.86).round()),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BotAppBar(
        selectedPage: AuthRoutes.conta,
      ),
    );
  }
}

class _SkillInfo {
  const _SkillInfo({
    required this.title,
    required this.goal,
    required this.date,
  });

  final String title;
  final String goal;
  final String date;

  DateTime get dateTime {
    final parts = date.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }
}
