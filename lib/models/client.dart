import 'address.dart';

class Client {
  String? id;
  String cnpj;
  String ie;
  String corporateName;
  String fantasyName;
  Address address;
  String typePerson;
  String email;
  String phone;
  String contact;
  String comment;

  Client({
    this.id,
    required this.cnpj,
    required this.ie,
    required this.corporateName,
    required this.fantasyName,
    required this.address,
    required this.typePerson,
    required this.email,
    required this.phone,
    required this.contact,
    required this.comment,
  });

  Client.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cnpj = json['cnpj'],
        ie = json['ie'],
        corporateName = json['corporateName'],
        fantasyName = json['fantasyName'],
        address = Address.fromJson(json['address']),
        typePerson = json['typePerson'],
        email = json['email'],
        phone = json['phone'],
        contact = json['contact'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
        'cnpj': cnpj,
        'ie': ie,
        'corporateName': corporateName,
        'fantasyName': fantasyName,
        'address': address.toJson(),
        'typePerson': typePerson,
        'email': email,
        'phone': phone,
        'contact': contact,
        'comment': comment,
      };
  static empty() => Client(
      address: Address.empty(),
      cnpj: '',
      comment: '',
      contact: '',
      corporateName: '',
      fantasyName: '',
      email: '',
      ie: '',
      phone: '',
      typePerson: '',);

}
