import 'endereco.dart';

class Cliente {
  final String id;
  final int cnpj;
  final String razaoSocial;
  final String nomeFantasia;
  final int ie;
  final ClienteEndereco endereco;

  Cliente(
    this.id,
    this.cnpj,
    this.razaoSocial,
    this.nomeFantasia,
    this.ie,
    this.endereco,
  );

  Cliente.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        cnpj = json['cnpj'] ?? 0,
        razaoSocial = json['razaoSocial'],
        nomeFantasia = json['nomeFantasia'],
        ie = json['ie'] ?? 0,
        endereco = ClienteEndereco.fromJson(json['endereco']);

  static Cliente empty = Cliente('', 0, '', '', 0, ClienteEndereco.empty);

  Map<String, dynamic> toJson() => {
        'id': id,
        'cnpj': cnpj,
        'razaoSocial': razaoSocial,
        'nomeFantasia': nomeFantasia,
        'ie': ie,
        'endereco': endereco.toJson(),
      };
}
