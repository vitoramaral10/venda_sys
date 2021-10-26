class Usuario {
  final String id;
  final String nome;
  final String email;
  final String imagem;
  final List<dynamic> empresas;

  Usuario(this.id, this.nome, this.email, this.imagem, this.empresas);

  Usuario.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'] ?? '',
        email = json['email'],
        imagem = json['imagem'] ??
            'https://i1.wp.com/terracoeconomico.com.br/wp-content/uploads/2019/01/default-user-image.png?ssl=1',
        empresas = json['empresas'];

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'email': email,
        'imagem': imagem,
        'empresas': empresas,
      };

  static Usuario empty = Usuario('', '', '', '', []);
}
