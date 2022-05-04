class NotaFiscalProduto {
  final String codigo;
  final String ean;
  final String descricao;
  final int ncm;
  final int cfop;
  final String unidadeMedida;
  final double quantidade;
  final double valorUnitario;
  final double valorTotal;
  final String eanTributavel;
  final String unidadeMedidaTributavel;
  final double quantidadeTributavel;
  final double valorUnitarioTributavel;
  final int indTot;

  NotaFiscalProduto(
    this.codigo,
    this.ean,
    this.descricao,
    this.ncm,
    this.cfop,
    this.unidadeMedida,
    this.quantidade,
    this.valorUnitario,
    this.valorTotal,
    this.eanTributavel,
    this.unidadeMedidaTributavel,
    this.quantidadeTributavel,
    this.valorUnitarioTributavel,
    this.indTot,
  );

  NotaFiscalProduto.fromJson(Map<String, dynamic> json)
      : codigo = json['codigo'],
        ean = json['ean'],
        descricao = json['descricao'],
        ncm = json['ncm'],
        cfop = json['cfop'],
        unidadeMedida = json['unidadeMedida'],
        quantidade = json['quantidade'],
        valorUnitario = json['valorUnitario'],
        valorTotal = json['valorTotal'],
        eanTributavel = json['eanTributavel'],
        unidadeMedidaTributavel = json['unidadeMedidaTributavel'],
        quantidadeTributavel = json['quantidadeTributavel'],
        valorUnitarioTributavel = json['valorUnitarioTributavel'],
        indTot = json['indTot'];

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'ean': ean,
        'descricao': descricao,
        'ncm': ncm,
        'cfop': cfop,
        'unidadeMedida': unidadeMedida,
        'quantidade': quantidade,
        'valorUnitario': valorUnitario,
        'valorTotal': valorTotal,
        'eanTributavel': eanTributavel,
        'unidadeMedidaTributavel': unidadeMedidaTributavel,
        'quantidadeTributavel': quantidadeTributavel,
        'valorUnitarioTributavel': valorUnitarioTributavel,
        'indTot': indTot,
      };
  static NotaFiscalProduto empty = NotaFiscalProduto('', '', '', 0, 0, '', 0, 0, 0, '', '', 0, 0, 0);

  static List<NotaFiscalProduto> fromMap(json) {
    return json.map<NotaFiscalProduto>((value) {
      return NotaFiscalProduto.fromJson(value);
    }).toList();
  }

  @override
  String toString() {
    return 'NotaFiscalProduto{codigo: $codigo, ean: $ean, descricao: $descricao, ncm: $ncm, cfop: $cfop, unidadeMedida: $unidadeMedida, quantidade: $quantidade, valorUnitario: $valorUnitario, valorTotal: $valorTotal, eanTributavel: $eanTributavel, unidadeMedidaTributavel: $unidadeMedidaTributavel, quantidadeTributavel: $quantidadeTributavel, valorUnitarioTributavel: $valorUnitarioTributavel, indTot: $indTot}';
  }
}
