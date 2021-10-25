import 'endereco.dart';

class NotaFiscalXMLDestinatario {
  final int cnpj;
  final String nome;
  final int indicadorIEDestinatario;
  final int ie;
  final NotaFiscalXMLEndereco endereco;

  NotaFiscalXMLDestinatario(
    this.cnpj,
    this.nome,
    this.indicadorIEDestinatario,
    this.ie,
    this.endereco,
  );

  NotaFiscalXMLDestinatario.fromJson(Map<String, dynamic> json)
      : cnpj = int.tryParse(json['CNPJ'])??0,
        nome = json['xNome'],
        indicadorIEDestinatario = int.parse(json['indIEDest']),
        ie = int.tryParse(json['IE'])?? 0,
        endereco = NotaFiscalXMLEndereco.fromJson(json['enderDest']);

  Map<String, dynamic> toJson() => {
        'cnpj': cnpj,
        'nome': nome,
        'indicadorIEDestinatario': indicadorIEDestinatario,
        'ie': ie,
        'endereco': endereco.toJson(),
      };
  static NotaFiscalXMLDestinatario empty = NotaFiscalXMLDestinatario(0, '', 0, 0, NotaFiscalXMLEndereco.empty);
}
