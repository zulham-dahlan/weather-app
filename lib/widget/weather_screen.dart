import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/api/api_service.dart';
import 'package:weather_app/data/model/weather.dart';
import 'package:weather_app/helper/weather_now.dart';
import 'package:weather_app/widget/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.id});

  final String id;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 4;
    DateTime now = DateTime.now();
    const String urlIcon = "https://ibnux.github.io/BMKG-importer/icon/";

    return Expanded(
      child: FutureBuilder<List<Weather>>(
        future: ApiService().weatherDetails(widget.id),
        builder: (context, AsyncSnapshot<List<Weather>> snapshotWeather) {
          if (snapshotWeather.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshotWeather.hasData) {
            Weather weatherNow = WeatherNow().getWeather(snapshotWeather.data!);
            return Column(
              children: [
                Text("${weatherNow.tempC}\u2103",
                    style: const TextStyle(
                      fontSize: 58,
                    )),
                const SizedBox(
                  height: 32,
                ),
                Text(DateFormat('EEEE, d MMMM yyyy HH:mm', "id_ID").format(now),
                    style: const TextStyle(fontSize: 12)),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  weatherNow.cuaca,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.network(
                  "$urlIcon${weatherNow.kodeCuaca}.png",
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 55,
                ),
                //TabBar untuk cuaca hari ini dan besok
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: 'Hari ini',
                    ),
                    Tab(
                      text: 'Besok',
                    )
                  ],
                ),
                //TabBar View untuk cuaca hari ini dan besok
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    //GridView hari ini
                    GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: (itemWidth / itemHeight),
                      children: List.generate(4, (index) {
                        var detailWeather = snapshotWeather.data![index];
                        return WeatherCard(
                          detailWeather: detailWeather,
                        );
                      }),
                    ),
                    //GridView besok
                    GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: (itemWidth / itemHeight),
                      children: List.generate(4, (index) {
                        var detailWeather = snapshotWeather.data![index + 4];
                        return WeatherCard(
                          detailWeather: detailWeather,
                        );
                      }),
                    ),
                  ]),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Terjadi sebuah kesalahan, silahkan coba lagi!'),
            );
          }
        },
      ),
    );
  }
}
