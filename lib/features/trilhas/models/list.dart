class ListItem {
  ListItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isSelected = false,
    this.date,
  });

  String title;
  String subtitle;
  void Function(ListItem) onTap;
  bool isSelected;
  String? date;
}

// TODO: atualizar para lista de tarefas.
class ClassifiedList {
  ClassifiedList({
    this.classifier,
    required this.items,
  });

  String? classifier;
  List<ListItem> items;
}