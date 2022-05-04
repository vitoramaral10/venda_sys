import 'endereco.dart';

class NotaFiscalDestinatario {
  final String cnpj;
  final String nome;
  final int indicadorIEDestinatario;
  final String ie;
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
  static NotaFiscalDestinatario empty =
      NotaFiscalDestinatario('', '', 0, '', NotaFiscalXMLEndereco.empty);

  @override
  String toString() {
    return 'NotaFiscalDestinatario{cnpj: $cnpj, nome: $nome, indicadorIEDestinatario: $indicadorIEDestinatario, ie: $ie, endereco: $endereco}';
  }
}
