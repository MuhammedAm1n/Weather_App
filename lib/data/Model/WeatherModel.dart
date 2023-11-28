import 'package:WeatherApp/domain/Enities/WeatherEnt.dart';

class WeatherModel extends Weather {
  WeatherModel(super.cityName, super.temp, super.mainCondations);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      json['name'],
      json['main']['temp'].toDouble(),
      json['weather'][0]['main'],
    );
  }
}
