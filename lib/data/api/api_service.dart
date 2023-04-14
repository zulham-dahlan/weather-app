import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_app/data/model/region.dart';
import 'package:weather_app/data/model/weather.dart';

class ApiService {
  static const String _baseUrl = 'https://ibnux.github.io/BMKG-importer/';
  static const String _regionList = 'cuaca/wilayah.json';
  static const String _weatherDetails = 'cuaca/';

  Future<List<Region>> listRegion() async {
    final response = await http.Client().get(Uri.parse(_baseUrl + _regionList));

    if (response.statusCode == 200) {
      return regionFromJson(response.body);
    } else {
      throw Exception('Failed to Load Region List');
    }
  }

  Future<List<Weather>> weatherDetails(String id) async {
    final response =
        await http.Client().get(Uri.parse('$_baseUrl$_weatherDetails$id.json'));

    if (response.statusCode == 200) {
      return weatherFromJson(response.body);
    } else {
      print('$_baseUrl$_weatherDetails.json');
      throw Exception('Failed to Load Weather Detail');
    }
  }
}
