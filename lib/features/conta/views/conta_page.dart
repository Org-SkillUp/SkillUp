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
  State<ContaPage> createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  final ContaRepository _repository = ContaRepository();

  User? _user;
  Future<ContaModel>? _contaFuture;

  @override
  void initState() {
    super.initState();

    _user = FirebaseAuth.instance.currentUser;
    final user = _user;
    if (user != null) {
      _contaFuture = _repository.fetchContaData(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _user;

    if (user == null) {
      return _buildScaffold(const Center(child: Text('Usuário não logado')));
    }

    return FutureBuilder<ContaModel>(
      future: _contaFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildScaffold(
            const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return _buildScaffold(
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Erro ao carregar dados da conta.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        return _buildScaffold(
          _ContaContent(
            user: user,
            conta:
                snapshot.data ??
                const ContaModel(trilhasAtivas: 0, tarefas: []),
          ),
        );
      },
    );
  }

  Widget _buildScaffold(Widget body) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: SafeArea(child: body),
      bottomNavigationBar: BotAppBar(selectedPage: AuthRoutes.conta),
    );
  }
}

class _ContaContent extends StatelessWidget {
  const _ContaContent({required this.user, required this.conta});

  final User user;
  final ContaModel conta;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final stateButton = Theme.of(context).extension<StateButtonTheme>()!;
    final muted = colorScheme.primary.withAlpha((255 * 0.64).round());

    return ListView(
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
                _userDisplayName(user),
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
                _formatLongDate(user.metadata.creationTime),
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
                iconColor: const Color(0xFF3BD3AC),
                iconBackgroundColor: const Color(0x333BD3AC),
                iconInValueRow: true,
                label: 'Trilhas Ativas',
                value: conta.trilhasAtivas.toString(),
                height: 96,
                width: 112,
                padding: const EdgeInsets.all(14),
                borderRadius: 12,
                labelFontSize: 12,
                valueFontSize: 22,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Indicator(
                icon: Icons.flag_outlined,
                iconColor: const Color(0xFFB7C430),
                iconBackgroundColor: const Color(0x33B7C430),
                iconInValueRow: true,
                label: 'Metas Criadas',
                value: conta.metasCriadas.toString(),
                height: 96,
                width: 112,
                padding: const EdgeInsets.all(14),
                borderRadius: 12,
                labelFontSize: 12,
                valueFontSize: 22,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Indicator(
                icon: Icons.workspace_premium_outlined,
                iconColor: const Color(0xFF59E66D),
                iconBackgroundColor: const Color(0x3359E66D),
                iconInValueRow: true,
                label: 'Habilidades',
                value: conta.habilidades.toString(),
                height: 96,
                width: 112,
                padding: const EdgeInsets.all(14),
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
              if (conta.tarefas.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nenhuma habilidade encontrada.',
                      style: textTheme.labelSmall?.copyWith(
                        color: muted.withAlpha((255 * 0.86).round()),
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              else
                ...conta.tarefas.map(
                  (tarefa) => CardItem(
                    item: ListItem(
                      title: tarefa.title,
                      subtitle: tarefa.goal,
                      onTap: _ignoreTap,
                    ),
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
                      _formatShortDate(tarefa.date),
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
    );
  }

  void _showDeactivateMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Função de desativar conta ainda não configurada.'),
      ),
    );
  }

  String _userDisplayName(User user) {
    final displayName = user.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) return displayName;

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
