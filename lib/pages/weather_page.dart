import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weartherapp/models/weather_model.dart';
import 'package:weartherapp/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService("bada4236233a989c7ed16d60b75f0ef8");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() => _weather = weather);
    } catch (e) {
      print(e);
    }
  }
  //fetch weather

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    }

    switch (mainCondition) {
      case 'Clear':
        return 'assets/sunny.json';
      case 'Rain':
        return 'assets/rainy icon.json';
      case 'Clouds':
        return 'assets/cloudy icon.json';
      case 'Snow':
        return 'assets/Snowing.json';
      case 'Thunderstorm':
        return 'assets/thunderstorm.json';
      case 'Drizzle':
        return 'assets/rainy icon.json';
      case 'Mist':
        return 'assets/cloudy icon.json';
      case 'Fog':
        return 'assets/cloudy icon.json';
      case 'Haze':
        return 'assets/cloudy icon.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();
    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? 'Loading...'),
            //animation placeholder
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temperature
            Text('${_weather?.temperature.round()}°C'),

            //weather condition
            Text(_weather?.mainCondition ?? ''),
          ],
        ),
      ),
    );
  }
}
