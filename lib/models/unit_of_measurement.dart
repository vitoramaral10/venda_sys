class UnitOfMeasurement {
  String? id;
  String description;
  String abbreviation;

  UnitOfMeasurement({
    this.id,
    required this.description,
    required this.abbreviation,
  });

  UnitOfMeasurement.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        abbreviation = json['abbreviation'];

  Map<String, dynamic> toJson() => {
        'description': description,
        'abbreviation': abbreviation,
      };

  @override
  String toString() {
    return 'UnitOfMeasurement{id: $id, description: $description, abbreviation: $abbreviation}';
  }
}
