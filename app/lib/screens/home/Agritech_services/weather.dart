import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage2 extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage2> {
  final TextEditingController _cityController = TextEditingController();
  String _weatherDescription = '';
  double _temperature = 0.0;
  bool _loading = false;
  String city="";

  Future<void> _fetchWeather(String city) async {
    final apiKey = 'YOUR_API_KEY';  // Replace with your API key
    final url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    setState(() {
      _loading = true;
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weatherDescription = data['weather'][0]['description'];
          _temperature = data['main']['temp'];
        });
      } else {
        setState(() {
          _weatherDescription = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _weatherDescription = 'Failed to fetch weather data';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Weather",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /*TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city',
                border: OutlineInputBorder(),
              ),
            ),*/
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _fetchWeather(city);
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 32),
            _loading
                ? CircularProgressIndicator()
                : Column(
              children: [
                Text(
                  _weatherDescription,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 8),
                Text(
                  '${_temperature.toStringAsFixed(1)}°C',
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
