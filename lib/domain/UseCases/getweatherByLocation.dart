import 'package:WeatherApp/domain/AbsRepositry/Absrepo.dart';

class GetWeatherByLocation {
  final AbsRepo repo;

  GetWeatherByLocation(this.repo);

  Future<String> execute() async {
    return await repo.getCurrentCity();
  }
}
