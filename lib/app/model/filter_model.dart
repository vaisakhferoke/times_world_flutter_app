// To parse this JSON data, do
//
//     final filterType = filterTypeFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

FilterType filterTypeFromJson(String str) =>
    FilterType.fromJson(json.decode(str));

String filterTypeToJson(FilterType data) => json.encode(data.toJson());

class FilterType {
  List<Datum> data;

  FilterType({
    required this.data,
  });

  factory FilterType.fromJson(Map<String, dynamic> json) => FilterType(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String name;
  String slug;
  RxBool isSelected;

  List<Taxonomy> taxonomies;

  Datum({
    required this.name,
    required this.slug,
    required this.taxonomies,
    required this.isSelected,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        slug: json["slug"],
        isSelected: false.obs,
        taxonomies: List<Taxonomy>.from(
            json["taxonomies"].map((x) => Taxonomy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "taxonomies": List<dynamic>.from(taxonomies.map((x) => x.toJson())),
      };
}

class Taxonomy {
  int? id;
  String? guid;
  String? slug;
  String? name;
  String? city;
  List<Location>? locations;
  RxBool isSelected;

  Taxonomy({
    this.id,
    this.guid,
    this.slug,
    this.name,
    this.city,
    this.locations,
    required this.isSelected,
  });

  factory Taxonomy.fromJson(Map<String, dynamic> json) => Taxonomy(
        id: json["id"],
        guid: json["Guid"],
        slug: json["slug"],
        name: json["name"],
        city: json["city"],
        isSelected: false.obs,
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"]!.map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Guid": guid,
        "slug": slug,
        "name": name,
        "city": city,
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
      };
}

class Location {
  int id;
  String guid;
  String slug;
  String name;

  Location({
    required this.id,
    required this.guid,
    required this.slug,
    required this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        guid: json["Guid"],
        slug: json["slug"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Guid": guid,
        "slug": slug,
        "name": name,
      };
}
