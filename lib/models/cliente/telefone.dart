class ClienteTelefone {
  final int telefone;
  final String contato;
  final String comentario;

  ClienteTelefone(
    this.telefone,
    this.contato,
    this.comentario,
  );

  ClienteTelefone.fromJson(Map<String, dynamic> json)
      : telefone = json['telefone'],
        contato = json['contato'],
        comentario = json['comentario'];

  Map<String, dynamic> toJson() => {
        'telefone': telefone,
        'contato': contato,
        'comentario': comentario,
      };
  static ClienteTelefone empty = ClienteTelefone(0, '', '');

  static fromJsonList(List<dynamic> json) {
    List<ClienteTelefone> list = json.map((e) {
      return ClienteTelefone.fromJson(e);
    }).toList();

    return list;
  }
}
