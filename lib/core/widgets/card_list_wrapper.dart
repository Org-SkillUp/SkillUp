import 'package:SkillUp/core/widgets/card_item.dart';
import 'package:SkillUp/features/trilhas/models/list_item.dart';
import 'package:flutter/material.dart';

class CardListWrapper extends StatelessWidget {
  const CardListWrapper({
    super.key,
    required this.title,
    required this.items,
    this.onAdd,
  });

  final String title;
  final List<ClassifiedList> items;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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