class CharactersEntity {
  final List<Character> list;

  CharactersEntity({required this.list});
}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String location;
  final String image;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.location,
    required this.image,
  });
}

extension CharacterExtension on Character {
  /// to json
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'location': location,
    'image': image,
  };
}
