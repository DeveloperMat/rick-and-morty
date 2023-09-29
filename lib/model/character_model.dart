// To parse this JSON data, do
//
//     final characterModel = characterModelFromJson(jsonString);

import 'dart:convert';

CharacterModel characterModelFromJson(String str) =>
    CharacterModel.fromJson(json.decode(str));

String characterModelToJson(CharacterModel data) => json.encode(data.toJson());

class CharacterModel {
  Info info;
  List<CharacterResult> results;

  CharacterModel({
    required this.info,
    required this.results,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        info: Info.fromJson(json["info"]),
        results: List<CharacterResult>.from(
            json["results"].map((x) => CharacterResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Info {
  int count;
  int pages;
  String next;
  dynamic prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class CharacterResult {
  int id;
  String? name;
  Status? status;
  Species? species;
  String? type;
  Gender? gender;
  Location? origin;
  Location? location;
  String? image;
  String? url;
  DateTime? created;

  CharacterResult({
    required this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.url,
    this.created,
  });

  factory CharacterResult.fromJson(Map<String, dynamic> json) =>
      CharacterResult(
        id: json["id"],
        name: json["name"] ?? 'unknow',
        status: statusValues.map[json["status"]] ?? Status.Desconocido,
        species: speciesValues.map[json["species"]] ?? Species.Desconocido,
        type: json["type"] ?? 'unknow',
        gender: genderValues.map[json["gender"]] ?? Gender.Desconocido,
        origin: Location.fromJson(json["origin"]),
        location: Location.fromJson(json["location"]),
        image: json["image"] ?? '',
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin!.toJson(),
        "location": location!.toJson(),
        "image": image,
        "url": url,
        "created": created!.toIso8601String(),
      };
}

// ignore: constant_identifier_names
enum Gender { Mujer, Hombre, Desconocido }

final genderValues = EnumValues({
  "Female": Gender.Mujer,
  "Male": Gender.Hombre,
  "unknown": Gender.Desconocido
});

class Location {
  String name;
  String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

// ignore: constant_identifier_names
enum Species { Alien, Humano, Pooppybutthole, Humanoide, Criatura, Desconocido }

final speciesValues = EnumValues({
  "Alien": Species.Alien,
  "Human": Species.Humano,
  "Poopybutthole": Species.Pooppybutthole,
  "Humanoid": Species.Humanoide,
  "Mythological Creature": Species.Criatura,
  "unknow": Species.Desconocido
});

// ignore: constant_identifier_names
enum Status { Vivo, Muerto, Desconocido }

final statusValues = EnumValues({
  "Alive": Status.Vivo,
  "Dead": Status.Muerto,
  "unknown": Status.Desconocido
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
