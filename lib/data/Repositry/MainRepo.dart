import 'package:WeatherApp/data/Drc/RemoteDrc.dart';
import 'package:WeatherApp/domain/AbsRepositry/Absrepo.dart';
import 'package:WeatherApp/domain/Enities/WeatherEnt.dart';

class WeatherRepositry implements AbsRepo {
  final AbsRemoteDataSource absRemoteDataSource;

  WeatherRepositry(this.absRemoteDataSource);
  @override
  Future<String> getCurrentCity() async {
    return await absRemoteDataSource.getLocation();
  }

  @override
  Future<Weather> getWeather(String cityName) async {
    return await absRemoteDataSource.getWeather(cityName);
  }
}
