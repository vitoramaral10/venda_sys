class Product {
  String? id;
  final String codigo;
  final String descricao;
  final String descricaoResumida;
  final double estoque;
  final double valorCompra;
  final double valorVenda;
  final int ncm;
  String un;

  Product(
    {this.id,
    required this.codigo,
    required this.descricao,
    required this.descricaoResumida,
    required this.estoque,
    required this.valorCompra,
    required this.valorVenda,
    required this.ncm,
    required this.un,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        codigo = json['codigo'],
        descricao = json['descricao'],
        descricaoResumida = json['descricaoResumida'] ?? '',
        valorCompra = double.tryParse(json['valorCompra'].toString()) ?? 0,
        valorVenda = double.tryParse(json['valorVenda'].toString()) ?? 0,
        estoque = double.tryParse(json['estoque'].toString()) ?? 0,
        ncm = int.tryParse(json['ncm'].toString()) ?? 0,
        un = json['un'];

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
