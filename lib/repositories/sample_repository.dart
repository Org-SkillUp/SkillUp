import 'dart:convert';

import 'package:proj/models/sample_model.dart';
import 'package:proj/services/api_services.dart';

class SampleRepository {
  final ApiService apiService;

  SampleRepository(this.apiService);

  Future<List<SampleModel>> fetchThroughRepo() async {
    final data = await apiService.fetch();

    return data;
  }
}
