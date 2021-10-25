import 'endereco.dart';

class NotaFiscalEmitente {
  final int cnpj;
  final String nome;
  final String nomeFantasia;
  final int ie;
  final int ctr;
  final NotaFiscalXMLEndereco endereco;

  NotaFiscalEmitente(
    this.cnpj,
    this.nome,
    this.nomeFantasia,
    this.ie,
    this.ctr,
    this.endereco,
  );

  NotaFiscalEmitente.fromJson(Map<String, dynamic> json)
      : cnpj = json['cnpj'],
        nome = json['nome'],
        nomeFantasia = json['nomeFantasia'],
        ie = json['ie'],
        ctr = json['ctr'],
        endereco = NotaFiscalXMLEndereco.fromJson(json['endereco']);

  Map<String, dynamic> toJson() => {
        'cnpj': cnpj,
        'nome': nome,
        'nomeFantasia': nomeFantasia,
        'ie': ie,
        'ctr': ctr,
        'endereco': endereco.toJson(),
      };
  static NotaFiscalEmitente empty = NotaFiscalEmitente(0, '', '', 0, 0, NotaFiscalXMLEndereco.empty);
}
