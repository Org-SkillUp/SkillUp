import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
import 'package:SkillUp/features/tarefas/validators/tarefa_date_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        dataInicio = TextEditingController(text: _formatDate(tarefa?.dataInicio)),
        dataPrazo = TextEditingController(text: _formatDate(tarefa?.dataPrazo)),
        dataConclusao = TextEditingController(text: _formatDate(tarefa?.dataConclusao)),
        meta = TextEditingController(text: tarefa?.metaRelacionada ?? ''),
        descricao = TextEditingController(text: tarefa?.descricao ?? '');

  final TextEditingController titulo;
  final TextEditingController dataInicio;
  final TextEditingController dataPrazo;
  final TextEditingController dataConclusao;
  final TextEditingController meta;
  final TextEditingController descricao;

  String? dataInicioErro;
  String? dataPrazoErro;

  static final _fmt = DateFormat('dd/MM/yyyy');

  static String _formatDate(DateTime? date) {
    if (date == null) return '';
    return _fmt.format(date);
  }

  static DateTime? _parseDate(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return null;
    try {
      return _fmt.parse(trimmed);
    } catch (_) {
      return null;
    }
  }

  /// Recarrega os campos com os valores de [tarefa].
  ///
  /// Usado ao (re)entrar no modo de edição para descartar quaisquer
  /// alterações não salvas e voltar ao estado atual da tarefa.
  void setFrom(TarefaDetail tarefa) {
    titulo.text = tarefa.titulo;
    dataInicio.text = _formatDate(tarefa.dataInicio);
    dataPrazo.text = _formatDate(tarefa.dataPrazo);
    dataConclusao.text = _formatDate(tarefa.dataConclusao);
    meta.text = tarefa.metaRelacionada ?? '';
    descricao.text = tarefa.descricao ?? '';
    limparErros();
  }

  void limparErros() {
    dataInicioErro = null;
    dataPrazoErro = null;
  }

  /// Valida os campos obrigatórios e retorna a primeira mensagem de erro.
  String? validar() {
    limparErros();

    if (titulo.text.trim().isEmpty) {
      return 'Informe ao menos o título da tarefa.';
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

  /// Monta um [TarefaDetail] a partir dos valores atuais dos campos.
  ///
  /// [trilhaId] é obrigatório pois não fica exposto em nenhum campo do
  /// formulário — deve ser passado pelo contexto (trilha selecionada).
  ///
  /// Na criação, omita [existente]. Na edição, passe a tarefa atual para
  /// preservar id e metadados de persistência (`createdAt`, `createdBy`, etc.).
  TarefaDetail toTarefa({
    required String trilhaId,
    TarefaDetail? existente,
  }) {
    return TarefaDetail(
      id: existente?.id,
      createdAt: existente?.createdAt,
      updatedAt: existente?.updatedAt,
      createdBy: existente?.createdBy,
      updatedBy: existente?.updatedBy,
      titulo: titulo.text.trim(),
      trilhaId: existente?.trilhaId ?? trilhaId,
      trilhaNome: existente?.trilhaNome,
      dataInicio: _parseDate(dataInicio.text),
      dataPrazo: _parseDate(dataPrazo.text),
      dataConclusao: _parseDate(dataConclusao.text),
      metaRelacionada: meta.text.trim().isEmpty ? null : meta.text.trim(),
      descricao: descricao.text.trim().isEmpty ? null : descricao.text.trim(),
      concluida: existente?.concluida ?? false,
    );
  }

  /// Libera todos os controladores. Deve ser chamado no `dispose` da tela
  /// para evitar vazamento de memória.
  void dispose() {
    titulo.dispose();
    dataInicio.dispose();
    dataPrazo.dispose();
    dataConclusao.dispose();
    meta.dispose();
    descricao.dispose();
  }
}
