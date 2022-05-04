import 'email.dart';
import 'endereco.dart';

class Cliente {
  String id;
  final String cnpj;
  final String ie;
  final String razaoSocial;
  final String nomeFantasia;
  ClienteEndereco endereco;
  final String tipoPessoa;
  final List<ClienteEmail> emails;
  final int telefone;
  final String contato;
  final String comentario;

  Cliente(
    this.id,
    this.cnpj,
    this.razaoSocial,
    this.nomeFantasia,
    this.ie,
    this.endereco,
    this.tipoPessoa,
    this.emails,
    this.telefone,
    this.contato,
    this.comentario,
  );

  Cliente.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        cnpj = json['cnpj'] ?? 0,
        razaoSocial = json['razaoSocial'],
        nomeFantasia = json['nomeFantasia'],
        ie = json['ie'] ?? 0,
        endereco = ClienteEndereco.fromJson(json['endereco']),
        tipoPessoa = json['tipoPessoa'],
        emails = ClienteEmail.fromJsonList(json['emails']),
        telefone = json['telefone'],
        contato = json['contato'],
        comentario = json['comentario'];

  Map<String, dynamic> toJson() => {
        'cnpj': cnpj,
        'razaoSocial': razaoSocial,
        'nomeFantasia': nomeFantasia,
        'ie': ie,
        'endereco': endereco.toJson(),
        'tipoPessoa': tipoPessoa,
        'emails': emails.map((e) => e.toJson()).toList(),
        'telefone': telefone,
        'contato': contato,
        'comentario': comentario,
      };

  static Cliente empty = Cliente(
    '',
    '',
    '',
    '',
    '',
    ClienteEndereco.empty,
    '',
    [],
    0,
    '',
    '',
  );

  @override
  String toString() {
    return 'Cliente{id: $id, cnpj: $cnpj, razaoSocial: $razaoSocial, nomeFantasia: $nomeFantasia, ie: $ie, endereco: $endereco, tipoPessoa: $tipoPessoa, emails: $emails, telefone: $telefone, contato: $contato, comentario: $comentario}';
  }
}
