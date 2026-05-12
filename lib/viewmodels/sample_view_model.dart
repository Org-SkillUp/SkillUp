import 'package:flutter/material.dart';
import 'package:proj/models/sample_model.dart';
import 'package:proj/repositories/sample_repository.dart';
import 'package:proj/services/api_services.dart';

class SampleViewModel extends ChangeNotifier {
  final SampleRepository repository;

  SampleViewModel(this.repository);

  List<SampleModel> sampleModels = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> loadSample() async {
    try {
      isLoading = true;
      errorMessage = '';
      notifyListeners();

      sampleModels = await repository.fetchThroughRepo();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
