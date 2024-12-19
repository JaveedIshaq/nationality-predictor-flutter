import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country_probability.dart';

class NationalityService {
  static const String _baseUrl = 'https://api.nationalize.io';

  Future<List<CountryProbability>> predictNationality(String name) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/?name=${Uri.encodeComponent(name)}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['country'] as List)
            .map((c) => CountryProbability(
                  countryId: c['country_id'],
                  probability: c['probability'],
                ))
            .toList();
      } else {
        throw Exception('Failed to load predictions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error predicting nationality: $e');
    }
  }
} 