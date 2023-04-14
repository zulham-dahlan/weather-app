import 'dart:convert';

List<Weather> weatherFromJson(String str) =>
    List<Weather>.from(json.decode(str).map((x) => Weather.fromJson(x)));

class Weather {
  Weather({
    required this.jamCuaca,
    required this.kodeCuaca,
    required this.cuaca,
    required this.humidity,
    required this.tempC,
    required this.tempF,
  });

  DateTime jamCuaca;
  String kodeCuaca;
  String cuaca;
  String humidity;
  String tempC;
  String tempF;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        jamCuaca: DateTime.parse(json["jamCuaca"]),
        kodeCuaca: json["kodeCuaca"],
        cuaca: json["cuaca"],
        humidity: json["humidity"],
        tempC: json["tempC"],
        tempF: json["tempF"],
      );
}
