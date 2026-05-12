import 'package:flutter/material.dart';
import 'package:proj/core/theme/app_theme.dart';
import 'package:proj/repositories/sample_repository.dart';
import 'package:proj/services/api_services.dart';
import 'package:proj/viewmodels/sample_view_model.dart';
import 'package:proj/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final repository = SampleRepository(apiService);

    return ChangeNotifierProvider(
      create: (_) => SampleViewModel(repository)..loadSample(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Teste",
        theme: AppTheme.lightTheme,
        home: const HomePage(),
      ),
    );
  }
}
