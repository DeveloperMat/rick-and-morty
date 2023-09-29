// To parse this JSON data, do
//
//     final episodesModel = episodesModelFromJson(jsonString);

import 'dart:convert';

EpisodesModel episodesModelFromJson(String str) =>
    EpisodesModel.fromJson(json.decode(str));

String episodesModelToJson(EpisodesModel data) => json.encode(data.toJson());

class EpisodesModel {
  List<EpisodesData>? results;

  EpisodesModel({
    this.results,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) => EpisodesModel(
        results: json["results"] == null
            ? []
            : List<EpisodesData>.from(
                json["results"]!.map((x) => EpisodesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class EpisodesData {
  int? id;
  String? name;
  String? airDate;
  String? episode;
  List<String>? characters;
  String? url;
  DateTime? created;

  EpisodesData({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  factory EpisodesData.fromJson(Map<String, dynamic> json) => EpisodesData(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: json["characters"] == null
            ? []
            : List<String>.from(json["characters"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": characters == null
            ? []
            : List<dynamic>.from(characters!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}
