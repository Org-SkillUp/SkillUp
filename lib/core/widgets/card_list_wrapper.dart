import 'package:SkillUp/core/widgets/card_item.dart';
import 'package:SkillUp/core/widgets/field_builder.dart';
import 'package:SkillUp/core/theme/state_button_theme.dart';
import 'package:SkillUp/features/trilhas/models/list.dart';
import 'package:flutter/material.dart';

class CardListWrapper extends StatefulWidget {
  const CardListWrapper({
    super.key,
    required this.title,
    required this.items,
    this.onAdd,
    this.onAddTarefa,
    this.onExpand,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<ClassifiedList> items;
  final VoidCallback? onAdd;
  final Future<void> Function(String titulo)? onAddTarefa;
  final VoidCallback? onExpand;

  @override
  State<CardListWrapper> createState() => _CardListWrapperState();
}

class _CardListWrapperState extends State<CardListWrapper> {
  bool _showInput = false;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _confirmar() async {
    final titulo = _controller.text.trim();
    if (titulo.isEmpty) return;

    await widget.onAddTarefa?.call(titulo);

    if (!mounted) return;
    _controller.clear();
    setState(() => _showInput = false);
  }

  void _toggleInput() {
    setState(() {
      _showInput = !_showInput;
      if (!_showInput) _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final stButton = Theme.of(context).extension<StateButtonTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arimo',
                  ),
                ),
                const SizedBox(height: 4),
                if (widget.subtitle != null)
                  Text(
                    widget.subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Arimo',
                      color: Colors.white.withAlpha(153),
                    ),
                  ),
              ],
            ),
            Row(
              children: [
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
                if (widget.onAddTarefa != null)
                  IconButton(
                    onPressed: _toggleInput,
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
          ],
        ),

        SizedBox(height: 12),

        ...widget.items.map((classifiedList) {
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
              ...groupItems.map((item) => CardItem(item: item)),
            ],
          );
        }),

        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: _showInput
              ? Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldBuilder.buildTextField(
                          hint: 'Nome da tarefa',
                          fillColor: colorScheme.surface,
                          controller: _controller,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _confirmar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: stButton.plainBackgroundColor,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: Icon(
                            Icons.check,
                            color: stButton.plainLabelColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}