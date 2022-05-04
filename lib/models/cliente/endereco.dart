class ClienteEndereco {
  final String logradouro;
  final String numero;
  final String bairro;
  final int municipioCodigo;
  final String municipio;
  final String uf;
  final String cep;
  final int paisCodigo;
  final String pais;
  final String complemento;

  ClienteEndereco(
    this.logradouro,
    this.numero,
    this.bairro,
    this.municipioCodigo,
    this.municipio,
    this.uf,
    this.cep,
    this.paisCodigo,
    this.pais,
    this.complemento,
  );

  ClienteEndereco.fromJson(Map<String, dynamic> json)
      : logradouro = json['logradouro'],
        numero = json['numero'],
        bairro = json['bairro'],
        municipioCodigo = json['municipioCodigo'] ?? 0,
        municipio = json['municipio'],
        uf = json['uf'],
        cep = json['cep'],
        paisCodigo = json['paisCodigo'] ?? 0,
        pais = json['pais'],
        complemento = json['complemento'];

  Map<String, dynamic> toJson() => {
        'logradouro': logradouro,
        'numero': numero,
        'bairro': bairro,
        'municipio': municipio,
        'uf': uf,
        'cep': cep,
        'paisCodigo': paisCodigo,
        'pais': pais,
        'complemento': complemento,
      };

      static ClienteEndereco empty = ClienteEndereco(
        '',
        '',
        '',
        0,
        '',
        '',
        '',
        0,
        '',
        '',
      );

  static List<ClienteEndereco> fromJsonList(List<dynamic> json) {
    List<ClienteEndereco> list = json.map((e) {
      return ClienteEndereco.fromJson(e);
    }).toList();

    return list;
  }

  @override
  String toString() {
    return 'ClienteEndereco{logradouro: $logradouro, numero: $numero, bairro: $bairro, municipioCodigo: $municipioCodigo, municipio: $municipio, uf: $uf, cep: $cep, paisCodigo: $paisCodigo, pais: $pais, complemento: $complemento}';
  }
}
