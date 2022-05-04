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
      : logradouro = json['logradouro'] ?? '',
        numero = json['numero'] ?? '',
        bairro = json['bairro'] ?? '',
        municipioCodigo = json['municipioCodigo'] ?? 0,
        municipio = json['municipio'] ?? '',
        uf = json['uf'] ?? '',
        cep = json['cep'] ?? '',
        paisCodigo = json['paisCodigo'] ?? 0,
        pais = json['pais'] ?? '',
        telefone = json['telefone'] ?? 0;

  Map<String, dynamic> toJson() => {
        'logradouro': logradouro,
        'numero': numero,
        'bairro': bairro,
        'municipio': municipio,
        'uf': uf,
        'cep': cep,
        'paisCodigo': paisCodigo,
        'pais': pais,
        'telefone': telefone,
      };
  static NotaFiscalXMLEndereco empty = NotaFiscalXMLEndereco('', '', '', 0, '', '', '', 0, '', 0);

  @override
  String toString() {
    return 'NotaFiscalXMLEndereco{logradouro: $logradouro, numero: $numero, bairro: $bairro, municipioCodigo: $municipioCodigo, municipio: $municipio, uf: $uf, cep: $cep, paisCodigo: $paisCodigo, pais: $pais, telefone: $telefone}';
  }
}
