import 'package:SkillUp/core/widgets/card_item.dart';
import 'package:SkillUp/features/tarefas/models/list.dart';
import 'package:flutter/material.dart';

class CardListWrapper extends StatefulWidget {
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
  State<CardListWrapper> createState() => _CardListWrapperState();
}

class _CardListWrapperState extends State<CardListWrapper> {
  final bool _showInput = false;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arimo',
                    ),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Arimo',
                        color: Colors.white.withAlpha(153),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (widget.onExpand != null)
              TextButton(
                onPressed: widget.onExpand,
                child: const Text(
                  'Ver todas',
                  style: TextStyle(
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            if (widget.onAdd != null)
              IconButton(
                onPressed: widget.onAdd,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _showInput ? Icons.close : Icons.add,
                    key: ValueKey(_showInput),
                    size: 20,
                    color: colorScheme.primary,
                  ),
                ),
                constraints: const BoxConstraints(maxHeight: 32, maxWidth: 32),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF44505D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                ),
              ),
          ],
        ),

        ...widget.items.map((classifiedList) {
          final classifier = classifiedList.classifier;
          final groupItems = classifiedList.items;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (classifier != null && classifier.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.only(bottom: 6, top: 16),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF373D44), width: 1),
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

              const SizedBox(height: 12),

              ...groupItems.asMap().entries.map((entry) {
                final isLast = entry.key == groupItems.length - 1;
                return Column(
                  children: [
                    CardItem(
                      item: entry.value,
                      showDateIcon: true,
                      showBottomDate: true,
                    ),
                    if (!isLast) const SizedBox(height: 12),
                  ],
                );
              }),
            ],
          );
        }),
      ],
    );
  }
}