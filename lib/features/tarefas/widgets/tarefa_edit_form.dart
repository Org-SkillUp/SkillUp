import 'package:SkillUp/core/widgets/selectable_title.dart';
import 'package:SkillUp/features/tarefas/controllers/tarefa_form_controllers.dart';
import 'package:SkillUp/features/tarefas/validators/tarefa_date_validator.dart';
import 'package:SkillUp/features/tarefas/widgets/tarefa_text_field.dart';
import 'package:flutter/material.dart';

/// Formulário editável com todos os campos de uma tarefa.
///
/// É reutilizado tanto na edição (tela de detalhe) quanto na criação de
/// tarefas. Os controladores chegam prontos via [TarefaFormControllers], de
/// modo que o ciclo de vida (criação/descarte) fique sob responsabilidade da
/// tela que de fato possui o estado.
class TarefaEditForm extends StatefulWidget {
  const TarefaEditForm({super.key, required this.controllers});

  final TarefaFormControllers controllers;

  @override
  State<TarefaEditForm> createState() => _TarefaEditFormState();
}

class _TarefaEditFormState extends State<TarefaEditForm> {
  TarefaFormControllers get _controllers => widget.controllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TarefaTextField(
          controller: _controllers.titulo,
          label: 'Título',
          hint: 'Nome da tarefa',
        ),
        const SizedBox(height: 16),
        SelectableTitle(
          label: 'Trilha',
          options: _controllers.trilhaOpcoes,
          selected: _controllers.trilhaSelecionada,
          onChanged: (value) {
            setState(() => _controllers.setTrilha(value));
          },
        ),
        if (_controllers.trilhaErro != null) ...[
          const SizedBox(height: 6),
          Text(
            _controllers.trilhaErro!,
            style: const TextStyle(
              color: Color(0xFFCF8080),
              fontSize: 12,
            ),
          ),
        ],
        const SizedBox(height: 16),
        TarefaTextField(
          controller: _controllers.dataInicio,
          label: 'Iniciado',
          hint: TarefaDateValidator.formatoHint,
          keyboardType: TextInputType.number,
          inputFormatters: [TarefaDateValidator.inputFormatter],
          errorText: _controllers.dataInicioErro,
        ),
        const SizedBox(height: 16),
        TarefaTextField(
          controller: _controllers.dataPrazo,
          label: 'Prazo',
          hint: TarefaDateValidator.formatoHint,
          keyboardType: TextInputType.number,
          inputFormatters: [TarefaDateValidator.inputFormatter],
          errorText: _controllers.dataPrazoErro,
        ),
        const SizedBox(height: 16),
        TarefaTextField(
          controller: _controllers.meta,
          label: 'Meta Relacionada',
          hint: 'Meta vinculada à tarefa',
        ),
        const SizedBox(height: 16),
        TarefaTextField(
          controller: _controllers.descricao,
          label: 'Descrição',
          hint: 'Descreva a tarefa',
          maxLines: 5,
        ),
      ],
    );
  }
}
