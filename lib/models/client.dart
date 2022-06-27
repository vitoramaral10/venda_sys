import 'address.dart';
import 'email.dart';

class Client {
  String? id;
  String cnpj;
  String ie;
  String corporateName;
  String fantasyName;
  Address address;
  String typePerson;
  List<Email>? emails;
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
    this.emails,
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
        address = json['address'],
        typePerson = json['typePerson'],
        emails = json['emails'],
        phone = json['phone'],
        contact = json['contact'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
        'cnpj': cnpj,
        'ie': ie,
        'corporateName': corporateName,
        'fantasyName': fantasyName,
        'address': address,
        'typePerson': typePerson,
        'emails': emails,
        'phone': phone,
        'contact': contact,
        'comment': comment,
      };
}
