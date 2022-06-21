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
        description = json['descricao'],
        abbreviation = json['sigla'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'descricao': description,
        'sigla': abbreviation,
      };

  @override
  String toString() {
    return 'UnitOfMeasurement{id: $id, description: $description, abbreviation: $abbreviation}';
  }
}
