import 'dart:convert';
import 'package:flutter/services.dart';

class CountryService {
  Future<Map<String, dynamic>> loadCountryData() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/countries.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return {
        for (var country in jsonList)
          country['alpha2']: {
            'name': country['name'],
            'emoji': country['emoji'],
          }
      };
    } catch (e) {
      throw Exception('Error loading country data: $e');
    }
  }

  String getCountryName(Map<String, dynamic>? countryData, String countryCode) {
    if (countryData == null) return countryCode;
    final countryInfo = countryData[countryCode];
    return countryInfo?['name'] ?? countryCode;
  }

  String getCountryEmoji(Map<String, dynamic>? countryData, String countryCode) {
    if (countryData == null) return '';
    final countryInfo = countryData[countryCode];
    return countryInfo?['emoji'] ?? '';
  }
} 