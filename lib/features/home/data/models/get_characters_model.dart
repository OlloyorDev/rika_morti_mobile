import 'package:rika_morti_mobile/features/home/domain/entities/characters_entity.dart';

class GetCharactersModel {
  GetCharactersModel({this.info, this.results});

  GetCharactersModel.fromJson(dynamic json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }

  Info? info;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (info != null) {
      map['info'] = info?.toJson();
    }
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  CharactersEntity get toEntity => CharactersEntity(
    list: (results ?? [])
        .map(
          (e) => Character(
            id: e.id ?? 0,
            name: e.name ?? '',
            status: e.status ?? '',
            species: e.species ?? '',
            location: e.location?.name ?? '',
            image: e.image ?? '',
          ),
        )
        .toList(),
  );
}

class Results {
  Results({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin = json['origin'] != null ? Origin.fromJson(json['origin']) : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    image = json['image'];
    episode = json['episode'] != null ? json['episode'].cast<String>() : [];
    url = json['url'];
    created = json['created'];
  }

  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Origin? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['status'] = status;
    map['species'] = species;
    map['type'] = type;
    map['gender'] = gender;
    if (origin != null) {
      map['origin'] = origin?.toJson();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['image'] = image;
    map['episode'] = episode;
    map['url'] = url;
    map['created'] = created;
    return map;
  }
}

class Location {
  Location({this.name, this.url});

  Location.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }

  String? name;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }
}

class Origin {
  Origin({this.name, this.url});

  Origin.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }

  String? name;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }
}

class Info {
  Info({this.count, this.pages, this.next, this.prev});

  Info.fromJson(dynamic json) {
    count = json['count'];
    pages = json['pages'];
    next = json['next'];
    prev = json['prev'];
  }

  int? count;
  int? pages;
  String? next;
  String? prev;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['pages'] = pages;
    map['next'] = next;
    map['prev'] = prev;
    return map;
  }
}
