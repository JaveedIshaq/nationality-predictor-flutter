import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/country_probability.dart';
import '../services/nationality_service.dart';
import '../services/country_service.dart';
import '../widgets/prediction_card.dart';
import '../widgets/search_input_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  final _nationalityService = NationalityService();
  final _countryService = CountryService();
  
  bool _isLoading = false;
  List<CountryProbability>? _results;
  String? _error;
  Map<String, dynamic>? _countryData;

  @override
  void initState() {
    super.initState();
    _loadCountryData();
  }

  Future<void> _loadCountryData() async {
    try {
      final data = await _countryService.loadCountryData();
      setState(() => _countryData = data);
    } catch (e) {
      print('Error loading country data: $e');
    }
  }

  Future<void> _predictNationality(String name) async {
    if (name.isEmpty) {
      setState(() => _error = 'Please enter a name');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _results = null;
    });

    try {
      final results = await _nationalityService.predictNationality(name);
      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'An error occurred. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nationality Predictor',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SearchInputCard(
                    controller: _nameController,
                    isLoading: _isLoading,
                    onSearch: () => _predictNationality(_nameController.text),
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  if (_results != null) ...[
                    const SizedBox(height: 30),
                    PredictionCard(
                      results: _results!,
                      searchedName: _nameController.text,
                      countryService: _countryService,
                      countryData: _countryData,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
} 