import 'email.dart';
import 'endereco.dart';

class Cliente {
  String id;
  final int cnpj;
  final String ie;
  final String razaoSocial;
  final String nomeFantasia;
  final List<ClienteEndereco> enderecos;
  final String tipoPessoa;
  final List<ClienteEmail> emails;
  int telefone;
  String contato;
  String comentario;

  Cliente(
    this.id,
    this.cnpj,
    this.razaoSocial,
    this.nomeFantasia,
    this.ie,
    this.enderecos,
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
        enderecos = ClienteEndereco.fromJsonList(json['enderecos']),
        tipoPessoa = json['tipoPessoa'],
        emails = ClienteEmail.fromJsonList(json['emails']),
        telefone = json['telefone'],
        contato = json['contato'],
        comentario = json['comentario'];

  static Cliente empty = Cliente('', 0, '', '', '', [], '', [], 0, '', '');

  Map<String, dynamic> toJson() => {
        'cnpj': cnpj,
        'razaoSocial': razaoSocial,
        'nomeFantasia': nomeFantasia,
        'ie': ie,
        'enderecos': enderecos.map((e) => e.toJson()).toList(),
        'tipoPessoa': tipoPessoa,
        'emails': emails.map((e) => e.toJson()).toList(),
        'telefone': telefone,
        'contato': contato,
        'comentario': comentario,
      };
}
