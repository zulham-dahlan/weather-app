import 'package:weather_app/data/model/weather.dart';

class WeatherNow {
  getWeather(List<Weather> weathers) {
    DateTime dateTime = DateTime.now();
    for (var x = 0; x < 4; x++) {
      if (dateTime.compareTo(weathers[x].jamCuaca) > 0 &&
          dateTime.compareTo(weathers[x + 1].jamCuaca) < 0) {
        return weathers[x];
      }
    }
  }
}
