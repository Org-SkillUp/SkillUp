import 'package:flutter/material.dart';

class ListItem {
  final String title;
  final String? subtitle;
  final DateTime? date;
  bool isSelected;
  VoidCallback? onOpen;
  void Function(ListItem)? onTap;

  ListItem({
    required this.title,
    this.subtitle,
    this.date,
    this.isSelected = false,
    this.onOpen,
    this.onTap,
  });

  bool? get concluida => null;
}

class ClassifiedList {
  ClassifiedList({
    this.classifier,
    required this.items,
  });

  String? classifier;
  List<ListItem> items;
}