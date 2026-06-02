import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/routes/tarefas_routes.dart';
import 'package:flutter/material.dart';

class TarefasNavigation {
  const TarefasNavigation._();

  /// Abre a tela de detalhe exibindo a [tarefa] tocada. A tarefa viaja como
  /// `arguments` da rota, de modo que a tela mostre os dados reais (e não um
  /// mock).
  static void goToDetalhe(BuildContext context, TarefaDetail tarefa) {
    Navigator.pushNamed(context, TarefasRoutes.detalhe, arguments: tarefa);
  }

  static void goToTrilhas(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      TarefasRoutes.trilhas,
      (route) => false,
    );
  }

  /// Abre a tela de criação de tarefa, mantendo a tela atual na pilha para
  /// que o usuário possa voltar caso desista.
  static void goToCriarTarefa(BuildContext context) {
    Navigator.pushNamed(context, TarefasRoutes.criar);
  }
}
