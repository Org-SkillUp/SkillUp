import 'package:flutter/material.dart';
import 'package:proj/viewmodels/sample_view_model.dart';
import 'package:proj/widgets/sample_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SampleViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Teste")),

      body: Builder(
        builder: (context) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage));
          }

          return ListView.builder(
            itemCount: viewModel.sampleModels.length,
            itemBuilder: (context, index) {
              return SampleWidget(sample: viewModel.sampleModels[index]);
            },
          );
        },
      ),
    );
  }
}
