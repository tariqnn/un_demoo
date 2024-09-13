import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/json_file.dart';

class ApiService {
  final String apiUrl = 'https://www.unhcrjo.org/jobs/api';

  Future<List<Vacancy>> fetchVacancies() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Vacancy.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vacancies');
    }
  }

  Future<List<String>> fetchJobTypes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // extract  job types from the data
      return data
          .map((job) => job['jobType'] as String?)
          .where((type) => type != null)
          .toSet()
          .cast<String>()
          .toList();
    } else {
      throw Exception('Failed to load job types');
    }
  }
}
