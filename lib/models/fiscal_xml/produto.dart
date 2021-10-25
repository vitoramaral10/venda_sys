class NotaFiscalXMLProduto {
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

  NotaFiscalXMLProduto(
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

  NotaFiscalXMLProduto.fromJson(Map<String, dynamic> json)
      : codigo = json['prod']['cProd'],
        ean = json['prod']['cEAN'],
        descricao = json['prod']['xProd'],
        ncm = int.tryParse(json['prod']['NCM']) ?? 0,
        cfop = int.tryParse(json['prod']['CFOP']) ?? 0,
        unidadeMedida = json['prod']['uCom'],
        quantidade = double.tryParse(json['prod']['qCom']) ?? 0,
        valorUnitario = double.tryParse(json['prod']['vUnCom']) ?? 0,
        valorTotal = double.tryParse(json['prod']['vProd']) ?? 0,
        eanTributavel = json['prod']['cEANTrib'],
        unidadeMedidaTributavel = json['prod']['uTrib'],
        quantidadeTributavel = double.tryParse(json['prod']['qTrib']) ?? 0,
        valorUnitarioTributavel = double.tryParse(json['prod']['vUnTrib']) ?? 0,
        indTot = int.tryParse(json['prod']['indTot']) ?? 0;

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
  static NotaFiscalXMLProduto empty = NotaFiscalXMLProduto('', '', '', 0, 0, '', 0, 0, 0, '', '', 0, 0, 0);

  static List<NotaFiscalXMLProduto> fromMap(json) {
    return json.map<NotaFiscalXMLProduto>((value) {
      return NotaFiscalXMLProduto.fromJson(value);
    }).toList();
  }
}
