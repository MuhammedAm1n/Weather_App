import 'package:WeatherApp/domain/Enities/WeatherEnt.dart';

abstract class AbsRepo {
  Future<Weather> getWeather(String cityName);
  Future<String> getCurrentCity();
}
