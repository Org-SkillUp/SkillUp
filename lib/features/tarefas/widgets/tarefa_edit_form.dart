import 'package:SkillUp/features/tarefas/controllers/tarefa_form_controllers.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_text_field.dart';
import 'package:flutter/material.dart';

/// Formulário editável com todos os campos de uma tarefa.
///
/// É reutilizado tanto na edição (tela de detalhe) quanto na criação de
/// tarefas. Os controladores chegam prontos via [TarefaFormControllers], de
/// modo que o ciclo de vida (criação/descarte) fique sob responsabilidade da
/// tela que de fato possui o estado.
class TarefaEditForm extends StatelessWidget {
  const TarefaEditForm({super.key, required this.controllers});

  final TarefaFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TarefaTextField(
          controller: controllers.titulo,
          label: 'Título',
          hint: 'Nome da tarefa',
        ),
        const SizedBox(height: 16),
        TarefaTextField(
          controller: controllers.trilha,
          label: 'Trilha',
          hint: 'Trilha relacionada',
        ),
        const SizedBox(height: 16),
        TarefaTextField(
          controller: controllers.dataInicio,
          label: 'Iniciado',
          hint: 'Ex.: 18 de abril de 2026',
        ),
        const SizedBox(height: 16),
        TarefaTextField(
          controller: controllers.dataPrazo,
          label: 'Prazo',
          hint: 'Ex.: 20 de abril de 2026',
        ),
        const SizedBox(height: 16),
        TarefaTextField(
          controller: controllers.meta,
          label: 'Meta Relacionada',
          hint: 'Meta vinculada à tarefa',
        ),
        const SizedBox(height: 16),
        TarefaTextField(
          controller: controllers.descricao,
          label: 'Descrição',
          hint: 'Descreva a tarefa',
          maxLines: 5,
        ),
      ],
    );
  }
}
