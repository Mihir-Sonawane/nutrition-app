import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  final String searchQuery;
  const ResultPage({super.key, required this.searchQuery});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<dynamic> data = [];
  bool isLoading = true;
  String error = '';

  Future<void> fetchNutrition() async {
    final url =
        'https://api.api-ninjas.com/v1/nutrition?query=${Uri.encodeComponent(widget.searchQuery)}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-Api-Key': 'lyGWM9+zyLjddooxCz+D0g==HACGk63G6X95MXRF',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> result = json.decode(response.body);
        setState(() {
          data = result;
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to fetch data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNutrition();
  }

  Widget buildCard(dynamic item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['name'] ?? '',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Sugar: ${item['sugar_g']} g'),
            Text('Fiber: ${item['fiber_g']} g'),
            Text('Carbs: ${item['carbohydrates_total_g']} g'),
            Text('Cholesterol: ${item['cholesterol_mg']} mg'),
            Text('Potassium: ${item['potassium_mg']} mg'),
            Text('Sodium: ${item['sodium_mg']} mg'),
            Text('Saturated Fat: ${item['fat_saturated_g']} g'),
            Text('Total Fat: ${item['fat_total_g']} g'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for "${widget.searchQuery}"'),
        backgroundColor: Colors.green.shade700,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
          ? Center(child: Text(error))
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return buildCard(data[index]);
        },
      ),
    );
  }
}
