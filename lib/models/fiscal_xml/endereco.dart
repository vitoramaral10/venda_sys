class NotaFiscalXMLEndereco {
  final String logradouro;
  final String numero;
  final String bairro;
  final int municipioCodigo;
  final String municipio;
  final String uf;
  final String cep;
  final int paisCodigo;
  final String pais;
  final int telefone;

  NotaFiscalXMLEndereco(
    this.logradouro,
    this.numero,
    this.bairro,
    this.municipioCodigo,
    this.municipio,
    this.uf,
    this.cep,
    this.paisCodigo,
    this.pais,
    this.telefone,
  );

  NotaFiscalXMLEndereco.fromJson(Map<String, dynamic> json)
      : logradouro = json['xLgr'],
        numero = json['nro'],
        bairro = json['xBairro'],
        municipioCodigo = int.tryParse(json['cMun']) ?? 0,
        municipio = json['xMun'],
        uf = json['UF'],
        cep = json['CEP'],
        paisCodigo = int.tryParse(json['cPais']) ?? 0,
        pais = json['xPais'],
        telefone = int.tryParse(json['fone'].toString()) ?? 0;

  Map<String, dynamic> toJson() => {
        'logradouro': logradouro,
        'numero': numero,
        'bairro': bairro,
        'municipioCodigo': municipioCodigo,
        'municipio': municipio,
        'uf': uf,
        'cep': cep,
        'paisCodigo': paisCodigo,
        'pais': pais,
        'telefone': telefone,
      };
  static NotaFiscalXMLEndereco empty = NotaFiscalXMLEndereco('', '', '', 0, '', '', '', 0, '', 0);
}
