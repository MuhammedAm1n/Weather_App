import 'package:WeatherApp/domain/Enities/WeatherEnt.dart';
import 'package:WeatherApp/domain/AbsRepositry/Absrepo.dart';

class GetWeatherByName {
  final AbsRepo repo;

  GetWeatherByName(this.repo);

  Future<Weather> execute(String cityName) async {
    return await repo.getWeather(cityName);
  }
}
