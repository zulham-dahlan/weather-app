import 'package:flutter/material.dart';
import 'package:weather_app/common/style.dart';
import 'package:weather_app/data/api/api_service.dart';
import 'package:weather_app/data/model/region.dart';
import 'package:weather_app/widget/weather_screen.dart';

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
        backgroundColor: customBlueColor,
        elevation: 0,
        title: const Center(
          child: Icon(
            Icons.sunny,
            color: Colors.white,
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
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[400]!,
                          ),
                        ),
                        child: DropdownButton<Region>(
                            hint: const Text('Pilih Kota Anda'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            underline: Container(),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: selectedRegion,
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
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    (id != null) ? WeatherScreen(id: id!) : const SizedBox()
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Terjadi sebuah kesalahan, silahkan coba lagi!'),
              );
            }
          }
        },
      ),
    );
  }
}
