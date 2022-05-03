import 'package:venda_sys/models/cliente/telefone.dart';

import 'email.dart';
import 'endereco.dart';

class Cliente {
  String id;
  final int cnpj;
  final int ie;
  final String razaoSocial;
  final String nomeFantasia;
  final List<ClienteEndereco> enderecos;
  final String tipoPessoa;
  final List<ClienteEmail> emails;
  final List<ClienteTelefone> telefones;

  Cliente(
    this.id,
    this.cnpj,
    this.razaoSocial,
    this.nomeFantasia,
    this.ie,
    this.enderecos,
    this.tipoPessoa,
    this.emails,
    this.telefones,
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
        telefones = ClienteTelefone.fromJsonList(json['telefones']);

  static Cliente empty = Cliente('', 0, '', '', 0, [], '', [], []);

  Map<String, dynamic> toJson() => {
        'cnpj': cnpj,
        'razaoSocial': razaoSocial,
        'nomeFantasia': nomeFantasia,
        'ie': ie,
        'enderecos': enderecos.map((e) => e.toJson()).toList(),
        'tipoPessoa': tipoPessoa,
        'emails': emails.map((e) => e.toJson()).toList(),
        'telefones': telefones.map((e) => e.toJson()).toList(),
      };
}
