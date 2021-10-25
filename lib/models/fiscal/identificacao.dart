class NotaFiscalIdentificacao {
  final int uf;
  final int tipo;
  final int serie;
  final int numeroNf;
  final DateTime dataEmissao;
  final DateTime datamovimentacao;
  final int finalidade;
  final int presencial;
  final String naturezaOperacao;

  NotaFiscalIdentificacao(
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

  NotaFiscalIdentificacao.fromJson(Map<String, dynamic> json)
      : uf = json['uf'],
        tipo = json['tipo'],
        serie = json['serie'],
        numeroNf = json['numeroNf'],
        dataEmissao = json['dataEmissao'].toDate(),
        datamovimentacao = json['datamovimentacao'].toDate(),
        finalidade = json['finalidade'],
        presencial = json['presencial'],
        naturezaOperacao = json['naturezaOperacao'];

  Map<String, dynamic> toJson() => {
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
  static NotaFiscalIdentificacao empty = NotaFiscalIdentificacao(0, 0, 0, 0, DateTime.now(), DateTime.now(), 0, 0, '');
}
