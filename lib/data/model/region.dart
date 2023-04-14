import 'dart:convert';

List<Region> regionFromJson(String str) =>
    List<Region>.from(json.decode(str).map((x) => Region.fromJson(x)));

class Region {
  Region({
    required this.id,
    required this.propinsi,
    required this.kota,
    required this.kecamatan,
    required this.lat,
    required this.lon,
  });

  String id;
  String propinsi;
  String kota;
  String kecamatan;
  String lat;
  String lon;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        propinsi: json["propinsi"],
        kota: json["kota"],
        kecamatan: json["kecamatan"],
        lat: json["lat"],
        lon: json["lon"],
      );
}
