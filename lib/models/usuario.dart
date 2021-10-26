class Usuario {
  final String nome;
  final String email;
  final String imagem;

  Usuario(this.nome, this.email, this.imagem);

  static Usuario empty = Usuario('', '', '');
}
