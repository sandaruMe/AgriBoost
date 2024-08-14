import 'package:flutter/material.dart';



class WeatherPage extends StatelessWidget {
  final String city = "Colombo ,Srilanka";
  final String currentTemperature = "22°C";
  final String currentCondition = "Sunny";
  final List<Map<String, String>> weeklyForecast = [
    {"day": "Monday", "condition": "Sunny", "temperature": "23°C"},
    {"day": "Tuesday", "condition": "Cloudy", "temperature": "20°C"},
    {"day": "Wednesday", "condition": "Rainy", "temperature": "18°C"},
    {"day": "Thursday", "condition": "Sunny", "temperature": "25°C"},
    {"day": "Friday", "condition": "Windy", "temperature": "19°C"},
    {"day": "Saturday", "condition": "Sunny", "temperature": "24°C"},
    {"day": "Sunday", "condition": "Cloudy", "temperature": "21°C"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather [$city]', style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCurrentWeather(),
            SizedBox(height: 20),
            _buildWeeklyForecast(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeather() {
    return Card(
      color: Colors.white24,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Current Weather",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 10),
            Text(
              currentTemperature,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold,color:Colors.blue ),
            ),
            SizedBox(height: 10),
            Text(
              currentCondition,
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyForecast() {
    return Expanded(
      child: ListView.builder(
        itemCount: weeklyForecast.length,
        itemBuilder: (context, index) {
          final forecast = weeklyForecast[index];
          return Card(
            color: _getCardColor(forecast["condition"]!),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: _getWeatherIcon(forecast["condition"]!),
              title: Text(forecast["day"]!),
              subtitle: Text(forecast["condition"]!),
              trailing: Text(forecast["temperature"]!),
            ),
          );
        },
      ),
    );
  }

  Color _getCardColor(String condition) {
    switch (condition) {
      case "Sunny":
        return Colors.orangeAccent;
      case "Cloudy":
        return Colors.grey;
      case "Rainy":
        return Colors.blueAccent;
      case "Windy":
        return Colors.lightGreen;
      default:
        return Colors.white;
    }
  }

  Icon _getWeatherIcon(String condition) {
    switch (condition) {
      case "Sunny":
        return Icon(Icons.wb_sunny, color: Colors.yellow);
      case "Cloudy":
        return Icon(Icons.cloud, color: Colors.grey);
      case "Rainy":
        return Icon(Icons.grain, color: Colors.blue);
      case "Windy":
        return Icon(Icons.waves, color: Colors.green);
      default:
        return Icon(Icons.help_outline, color: Colors.black);
    }
  }
}
