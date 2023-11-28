import 'package:WeatherApp/data/Drc/RemoteDrc.dart';
import 'package:WeatherApp/data/Repositry/MainRepo.dart';
import 'package:WeatherApp/domain/AbsRepositry/Absrepo.dart';
import 'package:WeatherApp/domain/Enities/WeatherEnt.dart';
import 'package:WeatherApp/domain/UseCases/getweatherByLocation.dart';
import 'package:WeatherApp/domain/UseCases/getweatherByName.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Weather? _weather;
  _fetchWeather() async {
    // get The Current city
    AbsRemoteDataSource absRemoteDataSource = RemoteDataSource();
    AbsRepo repo = WeatherRepositry(absRemoteDataSource);
    String cityName = await GetWeatherByLocation(repo).execute();
    print(cityName);
    //get Weather for city
    try {
      AbsRemoteDataSource absRemoteDataSource = RemoteDataSource();
      AbsRepo repo = WeatherRepositry(absRemoteDataSource);
      final weather = await GetWeatherByName(repo).execute(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

// weather animations
  String getweatherAnimation(String? mainCondtion) {
    if (mainCondtion == null) return 'assets/night.json'; // default to sunny

    switch (mainCondtion.toLowerCase()) {
      case 'clouds':
        return 'assets/cloudy.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'thunderstorm':
        return 'assets/thunderwithreain.json';
      case 'rain':
        return 'assets/rainy.json';
      case 'fog':
        return 'assets/cloudy.json';

      default:
        return 'assets/sunny.json';
    }
  }

//init state
  @override
  void initState() {
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "loading city..",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold)),
            //animation
            Lottie.asset(getweatherAnimation(_weather?.mainCondations)),
            //temp
            SizedBox(
              height: 10,
            ),
            Text(
              '${_weather?.temp.round()}  ° C "',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

            SizedBox(
              height: 10,
            ),
            Text(_weather?.mainCondations ?? " ",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
