import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BMIResultPage extends StatefulWidget {
  final String weight, height, unit;
  const BMIResultPage({
    super.key,
    required this.weight,
    required this.height,
    required this.unit,
  });

  @override
  State<BMIResultPage> createState() => _BMIResultPageState();
}

class _BMIResultPageState extends State<BMIResultPage> {
  Map<String, dynamic>? bmiData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchBMI();
  }

  Future<void> fetchBMI() async {
    final url = Uri.parse(
      'https://api.apiverve.com/v1/bmicalculator?weight=${widget.weight}&height=${widget.height}&unit=${widget.unit}',
    );

    final response = await http.get(
      url,
      headers: {
        'X-API-Key': '66b5e44a-f322-4423-a5b6-b91b16ddca58', // ✅ Correct API key
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        bmiData = result["data"];
        loading = false;
      });
    } else {
      setState(() {
        bmiData = null;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Result"),
        backgroundColor: const Color(0xFF56ab2f),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : bmiData == null
          ? const Center(
        child: Text(
          "Failed to load BMI data",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Height: ${bmiData!['height']}", style: textStyle),
                Text("Weight: ${bmiData!['weight']}", style: textStyle),
                Text("BMI: ${double.parse(bmiData!['bmi'].toString()).toStringAsFixed(2)}", style: textStyle),
                const SizedBox(height: 12),
                Text("Risk: ${bmiData!['risk']}", style: textStyle),
                const SizedBox(height: 12),
                const Text("Summary:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(bmiData!['summary']),
                const SizedBox(height: 8),
                const Text("Recommendation:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(bmiData!['recommendation']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final TextStyle textStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
