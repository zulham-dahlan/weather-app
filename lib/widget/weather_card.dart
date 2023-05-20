import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/model/weather.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.detailWeather});
  final Weather detailWeather;
  final String urlIcon = "https://ibnux.github.io/BMKG-importer/icon/";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 16),
      child: Column(
        children: [
          Text((DateFormat('HH:mm').format(detailWeather.jamCuaca)),
              style: const TextStyle(
                fontSize: 16,
              )),
          const SizedBox(
            height: 32,
          ),
          Image.network(
            "$urlIcon${detailWeather.kodeCuaca}.png",
            height: 25,
            width: 25,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            "${detailWeather.tempC} \u2103",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
