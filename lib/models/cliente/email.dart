class ClienteEmail {
  final String email;
  final bool status;

  ClienteEmail(
    this.email,
    this.status,
  );

  ClienteEmail.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'status': status,
      };
  static ClienteEmail empty = ClienteEmail('', false);

  static fromJsonList(List<dynamic> json) {
    List<ClienteEmail> list = json.map((e) {
      return ClienteEmail.fromJson(e);
    }).toList();

    return list;
  }
}
