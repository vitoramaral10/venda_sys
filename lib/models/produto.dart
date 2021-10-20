class Produto {
  final String id;
  final String codigo;
  final String descricao;
  final String descricaoResumida;
  final double? valorCompra;
  final double? valorVenda;
  final int? estoque;
  final int? ncm;
  final String un;

  Produto(
    this.id,
    this.codigo,
    this.descricao,
    this.descricaoResumida,
    this.un, {
    this.valorCompra = 0.00,
    this.valorVenda = 0.00,
    this.estoque = 0,
    this.ncm = 0,
  });

  Produto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        codigo = json['codigo'],
        descricao = json['descricao'],
        descricaoResumida = json['descricaoResumida'],
        valorCompra = json['valorCompra'],
        valorVenda = json['valorVenda'],
        estoque = json['estoque'],
        ncm = json['ncm'],
        un = json['un'];

  static Produto empty = Produto('', '', '', '', '');

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
