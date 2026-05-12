import 'package:flutter/material.dart';
import 'package:proj/models/sample_model.dart';

class SampleWidget extends StatelessWidget {
  final SampleModel sample;

  const SampleWidget({super.key, required this.sample});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sample.text, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
