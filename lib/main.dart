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
  final TextEditingController _controller = TextEditingController(); // Fix variable naming
  String _cityName = '';
  String _weatherInfo = '';
  List<Map<String, String>> _sevenDayForecast = [];

  // Function to simulate fetching current weather
  void _fetchCurrentWeather() {
    final Random random = Random();
    final int temperature = random.nextInt(16) + 15; // Random temp between 15 and 30
    final List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
    final String condition = conditions[random.nextInt(conditions.length)];

    setState(() {
      _cityName = _controller.text;
      _weatherInfo = 'Temperature: $temperature°C, Condition: $condition';  
    });
  }

  // Function to simulate fetching 7-day weather forecast
  void _fetchSevenDayForecast() {
    final Random random = Random();
    final List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];

    List<Map<String, String>> forecast = [];
    for (int i = 0; i < 7; i++) {
      int temp = random.nextInt(16) + 15; // Random temp for each day
      String cond = conditions[random.nextInt(conditions.length)]; // Random condition for each day
      forecast.add({
        'day': 'Day ${i + 1}',
        'temperature': '$temp°C',
        'condition': cond,
      });
    }

    setState(() {
      _cityName = _controller.text;
      _sevenDayForecast = forecast;  // Update the forecast data
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter the city name:',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _fetchCurrentWeather,
                child: const Text('Fetch Current Weather'),
              ),
              ElevatedButton(
                onPressed: _fetchSevenDayForecast,
                child: const Text('Fetch 7-Day Forecast'),
              ),
              const SizedBox(height: 20),
              if (_cityName.isNotEmpty) ...[
                Text(
                  _cityName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  _weatherInfo,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                if (_sevenDayForecast.isNotEmpty) ...[
                  const Text(
                    '7-Day Weather Forecast:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _sevenDayForecast.length,
                    itemBuilder: (context, index) {
                      final dayForecast = _sevenDayForecast[index];
                      return Card(
                        child: ListTile(
                          title: Text(dayForecast['day']!),
                          subtitle: Text(
                            '${dayForecast['temperature']}, ${dayForecast['condition']}',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
