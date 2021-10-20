class UnidadeMedida {
  final String id;
  final String descricao;
  final String sigla;

  UnidadeMedida(
    this.id,
    this.descricao,
    this.sigla,
  );

  UnidadeMedida.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        descricao = json['descricao'],
        sigla = json['sigla'];

  static UnidadeMedida empty = UnidadeMedida('', '', '',);

  Map<String, dynamic> toJson() => {
        'descricao': descricao,
        'sigla': sigla,
      };
}
