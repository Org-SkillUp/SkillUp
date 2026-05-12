import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proj/models/sample_model.dart';

// Chama serviço externo

class ApiService {
  Future<List<SampleModel>> fetch() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data
          .map((e) => SampleModel(id: e.hashCode, text: e.toString()))
          .toList();
    } else {
      throw Exception('Fail');
    }
  }
}
