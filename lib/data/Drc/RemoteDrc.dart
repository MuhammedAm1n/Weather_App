import 'dart:convert';
import 'package:WeatherApp/Statics/Statics.dart';
import 'package:WeatherApp/data/Model/WeatherModel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

abstract class AbsRemoteDataSource {
  Future<WeatherModel> getWeather(String cityName);
  Future<String> getLocation();
}

class RemoteDataSource implements AbsRemoteDataSource {
  @override
  Future<WeatherModel> getWeather(String cityName) async {
    var response = await http.get(Uri.parse(
        '${AppStatics.baseURL}/weather?q=$cityName&units=metric&appid=${AppStatics.Akey}'));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<String> getLocation() async {
    //get permisson from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return Future.error('Location denied');
    }
    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    //convert the location to list of placemark
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //extract the city name from the first placemark
    String? city = placemarks[0].administrativeArea;

    return city ?? " ";
  }
}
