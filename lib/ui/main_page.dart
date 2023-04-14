import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/style.dart';
import 'package:weather_app/data/api/api_service.dart';
import 'package:weather_app/data/model/region.dart';
import 'package:weather_app/data/model/weather.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Region>> _listRegion;
  Region? selectedRegion;
  String? id;

  @override
  void initState() {
    super.initState();
    _listRegion = ApiService().listRegion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text(
            'Weather',
            style: TextStyle(
              color: customBlueColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Region>>(
        future: _listRegion,
        builder: (context, AsyncSnapshot<List<Region>> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton<Region>(
                        elevation: 8,
                        underline: Container(
                          height: 2,
                          color: customBlueColor,
                        ),
                        value: selectedRegion ?? snapshot.data![0],
                        items: snapshot.data!.map((item) {
                          return DropdownMenuItem<Region>(
                            value: item,
                            child: Text(item.kota),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRegion = value;
                            id = selectedRegion!.id;
                          });
                        }),
                    const SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: FutureBuilder<List<Weather>>(
                        future: ApiService().weatherDetails(id ?? '501397'),
                        builder: (context,
                            AsyncSnapshot<List<Weather>> snapshotWeather) {
                          if (snapshotWeather.hasData) {
                            return ListView.builder(
                              itemCount: snapshotWeather.data!.length,
                              itemBuilder: (context, index) {
                                var detailWeather =
                                    snapshotWeather.data![index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Waktu : ${(DateFormat('dd-MM-yyyy HH:mm').format(detailWeather.jamCuaca))}"),
                                    Text("Cuaca : ${detailWeather.cuaca}"),
                                    Text("Suhu : ${detailWeather.tempC} C"),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (snapshotWeather.hasError) {
                            return Center(
                              child: Text(snapshotWeather.error.toString()),
                            );
                          } else {
                            return const Center(
                              child: Text(''),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          }
        },
      ),
    );
  }
}
