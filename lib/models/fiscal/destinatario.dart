import 'endereco.dart';

class NotaFiscalDestinatario {
  final int cnpj;
  final String nome;
  final int indicadorIEDestinatario;
  final int ie;
  final NotaFiscalXMLEndereco endereco;

  NotaFiscalDestinatario(
    this.cnpj,
    this.nome,
    this.indicadorIEDestinatario,
    this.ie,
    this.endereco,
  );

  NotaFiscalDestinatario.fromJson(Map<String, dynamic> json)
      : cnpj = json['cnpj'],
        nome = json['nome'],
        indicadorIEDestinatario = json['indicadorIEDestinatario'],
        ie = json['ie'],
        endereco = NotaFiscalXMLEndereco.fromJson(json['endereco']);

  Map<String, dynamic> toJson() => {
        'cnpj': cnpj,
        'nome': nome,
        'indicadorIEDestinatario': indicadorIEDestinatario,
        'ie': ie,
        'endereco': endereco.toJson(),
      };
  static NotaFiscalDestinatario empty = NotaFiscalDestinatario(0, '', 0, 0, NotaFiscalXMLEndereco.empty);
}
