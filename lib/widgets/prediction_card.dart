import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/country_probability.dart';
import '../services/country_service.dart';

class PredictionCard extends StatelessWidget {
  final List<CountryProbability> results;
  final String searchedName;
  final CountryService countryService;
  final Map<String, dynamic>? countryData;

  const PredictionCard({
    super.key,
    required this.results,
    required this.searchedName,
    required this.countryService,
    required this.countryData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Predictions for "$searchedName"',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...results.map((result) {
              final percentage = (result.probability * 100).toStringAsFixed(1);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Text(
                      countryService.getCountryEmoji(countryData, result.countryId),
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            countryService.getCountryName(countryData, result.countryId),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: result.probability,
                            backgroundColor: Colors.deepPurple.withOpacity(0.1),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    ).animate().fadeIn().slideY();
  }
} 