import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/core/widgets/bot_app_bar.dart';
import 'package:SkillUp/core/widgets/indicator.dart';
import 'package:SkillUp/core/widgets/quantity_indicator.dart';
import 'package:SkillUp/core/widgets/selectable_title.dart';
import 'package:SkillUp/core/widgets/state_button.dart';
import 'package:SkillUp/core/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';

const options = [
  'Administração de Empresas',
  'Tecnologia',
  'Design',
];

const cardsInfo = [
  "14/03/2026",
  "Ativa"
];

class TrilhasPage extends StatelessWidget {
  const TrilhasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stButton = Theme.of(context).extension<StateButtonTheme>()!;
    
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
                    underLabel: '1 de 2 tarefas concluídas',
                    options: options,
                    selected: options[0],
                    onChanged: (_) {},
                  ),
                ),

                const SizedBox(width: 28),

                // TODO: implementar lógica de cálculo de progresso
                QuantityIndicator(value: "50%")
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Indicator(
                    icon: Icons.calendar_today_outlined,
                    label: 'Início',
                    value: cardsInfo[0],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Indicator(
                    icon: Icons.circle,
                    label: 'Status',
                    value: cardsInfo[1],
                    // TODO: implementar cores dinâmicas de acordo com status
                    dotColor: const Color(0xFF55B3D5),
                    valueColor: const Color(0xFF55B3D5),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Column(
              children: [
                StateButton(
                  onPressed: () {},
                  label: Text(
                    'PAUSAR',
                    style: TextStyle(
                      color: stButton.outlinedYellowHighlighColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  bgColor: stButton.outlinedBackgroundColor,
                  borderColor: stButton.outlinedYellowHighlighColor,
                  borderRadius: 14,
                ),
                const SizedBox(height: 16),
                StateButton(
                  onPressed: () {},
                  label: Text(
                    'NOVA TRILHA',
                    style: TextStyle(
                      color: stButton.plainLabelColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  bgColor: stButton.plainBackgroundColor,
                  borderRadius: 16,
                  icon: Icon(Icons.add, color: stButton.plainLabelColor),
                ),
              ],
            ),

            Column(
              children: [
                // Lista de tarefas
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BotAppBar(
        selectedIndex: 1,
        onTabChanged: (_) {},
      ),
    );
  }
}