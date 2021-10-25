class Produto {
  final String id;
  final String codigo;
  final String descricao;
  final String descricaoResumida;
  final double estoque;
  final double valorCompra;
  final double valorVenda;
  final int ncm;
  String un;

  Produto(
    this.id,
    this.codigo,
    this.descricao,
    this.descricaoResumida,
    this.estoque,
    this.valorCompra,
    this.valorVenda,
    this.ncm,
    this.un,
  );

  Produto.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        codigo = json['codigo'],
        descricao = json['descricao'],
        descricaoResumida = json['descricaoResumida'] ?? '',
        valorCompra = double.tryParse(json['valorCompra'].toString()) ?? 0,
        valorVenda = double.tryParse(json['valorVenda'].toString()) ?? 0,
        estoque = double.tryParse(json['estoque'].toString()) ?? 0,
        ncm = int.tryParse(json['ncm'].toString()) ?? 0,
        un = json['un'];

  static Produto empty = Produto('', '', '', '', 0, 0, 0, 0, '');

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'descricao': descricao,
        'descricaoResumida': descricaoResumida,
        'valorCompra': valorCompra,
        'valorVenda': valorVenda,
        'estoque': estoque,
        'ncm': ncm,
        'un': un,
      };
}
