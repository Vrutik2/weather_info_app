import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Info App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather Info'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  final TextEditingController _controller =
      TextEditingController(); // Fix variable naming
  String _cityName = '';
  String _weatherInfo = '';

  void _fetchWeather() {
    final Random random = Random();
    final int temperature = random.nextInt(16) +
        15; // Generates random temperature between 15 and 30
    final List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
    final String condition = conditions[random
        .nextInt(conditions.length)]; // Randomly selects a weather condition

    setState(() {
      _cityName = _controller.text;
      _weatherInfo = 'Temperature: $temperature°C, Condition: $condition';  
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter the city name:',
              ),
            ),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Fetch Weather'),
            ),
            Text(_cityName),
            Text(_weatherInfo),
          ],
        ),
      ),
    );
  }
}
