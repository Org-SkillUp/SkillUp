import 'package:SkillUp/core/widgets/card_item.dart';
import 'package:SkillUp/features/trilhas/models/list_item.dart';
import 'package:flutter/material.dart';

class CardListWrapper extends StatelessWidget {
  const CardListWrapper({
    super.key,
    required this.title,
    required this.items,
    this.onAdd,
    this.onExpand,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<ClassifiedList> items;
  final VoidCallback? onAdd;
  final VoidCallback? onExpand;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arimo',
                  ),
                ),

                SizedBox(height: 4),

                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Arimo',
                      color: Colors.white.withAlpha(153)
                    ),
                  ),
              ],
            ),
            if (onAdd != null)
              IconButton(
                onPressed: onAdd,
                icon: Icon(Icons.add, size: 20, color: colorScheme.primary),
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  maxHeight: 32,
                  maxWidth: 32
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Color(0xFF44505D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                ),
              ),

            if (onExpand != null)
              TextButton(
                onPressed: () {}, //TODO: Implementar lista de tarefas expandida
                child: const Text(
                  "Ver todas",
                  style: TextStyle(
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),
                ),
              ),
          ],
        ),

        ...items.map((classifiedList) {
          final classifier = classifiedList.classifier;
          final groupItems = classifiedList.items;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (classifier != null) ...[
                Container(
                  padding: const EdgeInsets.only(bottom: 6, top: 16),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFF373D44),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    classifier.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Arimo',
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary.withAlpha((255 * 0.8).round()),
                      letterSpacing: 0.35,
                    ),
                  ),
                ),

                const SizedBox(height: 12),
              ],
              ...groupItems.map((item) => CardItem(item: item)),
            ],
          );
        }),
      ],
    );
  }
}