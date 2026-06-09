import 'package:flutter/material.dart';

abstract interface class ListItem {
  String get title;
  String? get subtitle;
  bool get isSelected;
  set isSelected(bool boolState) {
    isSelected = boolState;
  }
  DateTime? get date;
  VoidCallback? get onOpen;
  VoidCallback? get onTap;
}

class ClassifiedList {
  ClassifiedList({
    this.classifier,
    required this.items,
  });

  String? classifier;
  List<ListItem> items;
}