import 'endereco.dart';

class NotaFiscalXMLEmitente {
  final int cnpj;
  final String nome;
  final String nomeFantasia;
  final int ie;
  final int ctr;
  final NotaFiscalXMLEndereco endereco;

  NotaFiscalXMLEmitente(
    this.cnpj,
    this.nome,
    this.nomeFantasia,
    this.ie,
    this.ctr,
    this.endereco,
  );

  NotaFiscalXMLEmitente.fromJson(Map<String, dynamic> json)
      : cnpj = int.tryParse(json['CNPJ']) ?? 0,
        nome = json['xNome'],
        nomeFantasia = json['xFant'],
        ie = int.tryParse(json['IE']) ?? 0,
        ctr = int.tryParse(json['CRT']) ?? 0,
        endereco = NotaFiscalXMLEndereco.fromJson(json['enderEmit']);

  Map<String, dynamic> toJson() => {
        'cnpj': cnpj,
        'nome': nome,
        'nomeFantasia': nomeFantasia,
        'ie': ie,
        'ctr': ctr,
        'endereco': endereco.toJson(),
      };
  static NotaFiscalXMLEmitente empty = NotaFiscalXMLEmitente(0, '', '', 0, 0, NotaFiscalXMLEndereco.empty);
}
