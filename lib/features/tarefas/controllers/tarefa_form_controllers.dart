import 'package:SkillUp/features/tarefas/models/tarefa_detail.dart';
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
        trilha = TextEditingController(text: tarefa?.trilhaNome ?? ''),
        dataInicio = TextEditingController(text: tarefa?.dataInicio ?? ''),
        dataPrazo = TextEditingController(text: tarefa?.dataPrazo ?? ''),
        meta = TextEditingController(text: tarefa?.metaRelacionada ?? ''),
        descricao = TextEditingController(text: tarefa?.descricao ?? '');

  final TextEditingController titulo;
  final TextEditingController trilha;
  final TextEditingController dataInicio;
  final TextEditingController dataPrazo;
  final TextEditingController meta;
  final TextEditingController descricao;

  /// Recarrega os campos com os valores de [tarefa].
  ///
  /// Usado ao (re)entrar no modo de edição para descartar quaisquer
  /// alterações não salvas e voltar ao estado atual da tarefa.
  void setFrom(TarefaDetail tarefa) {
    titulo.text = tarefa.titulo;
    trilha.text = tarefa.trilhaNome;
    dataInicio.text = tarefa.dataInicio;
    dataPrazo.text = tarefa.dataPrazo;
    meta.text = tarefa.metaRelacionada;
    descricao.text = tarefa.descricao;
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
      trilhaNome: trilha.text.trim(),
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
    trilha.dispose();
    dataInicio.dispose();
    dataPrazo.dispose();
    meta.dispose();
    descricao.dispose();
  }
}
