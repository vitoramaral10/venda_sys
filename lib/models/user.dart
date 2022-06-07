class User {
  final String id;
  final String name;
  final String email;
  final String imagem;
  final List<dynamic> empresas;

  static User empty = User('', '', '', '', []);

  User(this.id, this.name, this.email, this.imagem, this.empresas);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['nome'] ?? '',
        email = json['email'],
        imagem = json['imagem'] ??
            'https://i1.wp.com/terracoeconomico.com.br/wp-content/uploads/2019/01/default-user-image.png?ssl=1',
        empresas = json['empresas'];

  Map<String, dynamic> toJson() => {
        'nome': name,
        'email': email,
        'imagem': imagem,
        'empresas': empresas,
      };
}
