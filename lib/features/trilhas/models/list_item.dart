import 'package:flutter/foundation.dart';

class ListItem {
  ListItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isSelected = false,
    this.date,
    this.onOpen,
  });

  String title;
  String subtitle;
  void Function(ListItem) onTap;
  bool isSelected;
  String? date;

  /// Ação executada ao tocar no título do card (abrir o detalhe da tarefa).
  /// É opcional: quando nulo, o título não dispara navegação. Manter como
  /// callback evita que o widget de UI (core) conheça as rotas das features.
  VoidCallback? onOpen;
}

class ClassifiedList {
  ClassifiedList({
    this.classifier,
    required this.items,
  });

  String? classifier;
  List<ListItem> items;
}