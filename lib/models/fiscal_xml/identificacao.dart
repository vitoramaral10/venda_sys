class NotaFiscalXMLIdentificacao {
  final int codigoNota;
  final int uf;
  final int tipo;
  final int serie;
  final int numeroNf;
  final DateTime dataEmissao;
  final DateTime datamovimentacao;
  final int finalidade;
  final int presencial;
  final String naturezaOperacao;

  NotaFiscalXMLIdentificacao(
    this.codigoNota,
    this.uf,
    this.tipo,
    this.serie,
    this.numeroNf,
    this.dataEmissao,
    this.datamovimentacao,
    this.finalidade,
    this.presencial,
    this.naturezaOperacao,
  );

  NotaFiscalXMLIdentificacao.fromJson(Map<String, dynamic> json)
      : codigoNota = int.tryParse(json['cNF']) ?? 0,
        uf = int.tryParse(json['cUF']) ?? 0,
        tipo = int.tryParse(json['tpNF']) ?? 0,
        serie = int.tryParse(json['serie']) ?? 0,
        numeroNf = int.tryParse(json['nNF']) ?? 0,
        dataEmissao = DateTime.tryParse(json['dhEmi']) ?? DateTime.now(),
        datamovimentacao = DateTime.tryParse(json['dhSaiEnt']) ?? DateTime.now(),
        finalidade = int.tryParse(json['indFinal']) ?? 0,
        presencial = int.tryParse(json['indPres']) ?? 0,
        naturezaOperacao = json['natOp'];

  Map<String, dynamic> toJson() => {
        'codigoNota': codigoNota,
        'uf': uf,
        'tipo': tipo,
        'serie': serie,
        'numeroNf': numeroNf,
        'dataEmissao': dataEmissao,
        'datamovimentacao': datamovimentacao,
        'finalidade': finalidade,
        'presencial': presencial,
        'naturezaOperacao': naturezaOperacao,
      };
  static NotaFiscalXMLIdentificacao empty =
      NotaFiscalXMLIdentificacao(0, 0, 0, 0, 0, DateTime.now(), DateTime.now(), 0, 0, '');
}
