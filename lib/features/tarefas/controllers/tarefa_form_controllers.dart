import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/validators/tarefa_date_validator.dart';
import 'package:SkillUp/features/trilhas/data/trilhas_disponiveis.dart';
import 'package:flutter/material.dart';

/// Agrupa os [TextEditingController] usados nos formulários de tarefa.
///
/// Centralizar os controladores aqui evita repetir a criação, o
/// preenchimento e o descarte deles em cada tela (edição e criação),
/// respeitando o princípio DRY e mantendo cada tela mais enxuta.
class TarefaFormControllers {
  /// Cria os controladores já preenchidos com os dados de [tarefa].
  /// Quando [tarefa] é nulo, os campos começam vazios (modo criação).
  TarefaFormControllers({TarefaDetail? tarefa})
      : titulo = TextEditingController(text: tarefa?.titulo ?? ''),
        trilhaSelecionada = tarefa?.trilhaNome ?? '',
        dataInicio = TextEditingController(text: tarefa?.dataInicio ?? ''),
        dataPrazo = TextEditingController(text: tarefa?.dataPrazo ?? ''),
        meta = TextEditingController(text: tarefa?.metaRelacionada ?? ''),
        descricao = TextEditingController(text: tarefa?.descricao ?? '');

  final TextEditingController titulo;
  String trilhaSelecionada;
  final TextEditingController dataInicio;
  final TextEditingController dataPrazo;
  final TextEditingController meta;
  final TextEditingController descricao;

  String? trilhaErro;
  String? dataInicioErro;
  String? dataPrazoErro;

  /// Opções exibidas no dropdown, incluindo trilhas legadas fora da lista padrão.
  List<String> get trilhaOpcoes {
    if (trilhaSelecionada.isNotEmpty &&
        !TrilhasDisponiveis.nomes.contains(trilhaSelecionada)) {
      return [trilhaSelecionada, ...TrilhasDisponiveis.nomes];
    }
    return TrilhasDisponiveis.nomes;
  }

  void setTrilha(String value) {
    trilhaSelecionada = value;
    trilhaErro = null;
  }

  /// Recarrega os campos com os valores de [tarefa].
  ///
  /// Usado ao (re)entrar no modo de edição para descartar quaisquer
  /// alterações não salvas e voltar ao estado atual da tarefa.
  void setFrom(TarefaDetail tarefa) {
    titulo.text = tarefa.titulo;
    trilhaSelecionada = tarefa.trilhaNome;
    dataInicio.text = tarefa.dataInicio;
    dataPrazo.text = tarefa.dataPrazo;
    meta.text = tarefa.metaRelacionada;
    descricao.text = tarefa.descricao;
    limparErros();
  }

  void limparErros() {
    trilhaErro = null;
    dataInicioErro = null;
    dataPrazoErro = null;
  }

  /// Valida os campos obrigatórios e retorna a primeira mensagem de erro.
  String? validar() {
    limparErros();

    if (titulo.text.trim().isEmpty) {
      return 'Informe ao menos o título da tarefa.';
    }

    if (trilhaSelecionada.trim().isEmpty) {
      trilhaErro = 'Selecione uma trilha.';
      return trilhaErro;
    }

    dataInicioErro =
        TarefaDateValidator.validate(dataInicio.text, campo: 'início');
    if (dataInicioErro != null) return dataInicioErro;

    dataPrazoErro = TarefaDateValidator.validate(dataPrazo.text, campo: 'prazo');
    if (dataPrazoErro != null) return dataPrazoErro;

    final inicio = TarefaDateValidator.parse(dataInicio.text)!;
    final prazo = TarefaDateValidator.parse(dataPrazo.text)!;
    if (prazo.isBefore(inicio)) {
      dataPrazoErro = 'O prazo não pode ser anterior à data de início.';
      return dataPrazoErro;
    }

    return null;
  }

  /// Monta um [TarefaDetail] imutável a partir dos valores atuais dos campos.
  ///
  /// Os textos são "aparados" (trim) para evitar espaços acidentais nas
  /// pontas das informações digitadas pelo usuário.
  ///
  /// Na criação, omita [existente]. Na edição, passe a tarefa atual para
  /// preservar id e metadados de persistência (`createdAt`, `createdBy`, etc.).
  TarefaDetail toTarefa({TarefaDetail? existente}) {
    return TarefaDetail(
      id: existente?.id,
      createdAt: existente?.createdAt,
      updatedAt: existente?.updatedAt,
      createdBy: existente?.createdBy,
      updatedBy: existente?.updatedBy,
      titulo: titulo.text.trim(),
      trilhaNome: trilhaSelecionada.trim(),
      dataInicio: dataInicio.text.trim(),
      dataPrazo: dataPrazo.text.trim(),
      metaRelacionada: meta.text.trim(),
      descricao: descricao.text.trim(),
    );
  }

  /// Libera todos os controladores. Deve ser chamado no `dispose` da tela
  /// para evitar vazamento de memória.
  void dispose() {
    titulo.dispose();
    dataInicio.dispose();
    dataPrazo.dispose();
    meta.dispose();
    descricao.dispose();
  }
}
