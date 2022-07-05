class Address {
  String street;
  String number;
  String district;
  int cityCode;
  String city;
  String uf;
  String cep;
  int countryCode;
  String country;
  String complement;

  Address({
    required this.street,
    required this.number,
    required this.district,
    required this.cityCode,
    required this.city,
    required this.uf,
    required this.cep,
    required this.countryCode,
    required this.country,
    required this.complement,
  });

  Address.fromJson(Map<String, dynamic> json)
      : street = json['street'],
        number = json['number'],
        district = json['district'],
        cityCode = json['cityCode'],
        city = json['city'],
        uf = json['uf'],
        cep = json['cep'],
        countryCode = json['countryCode'],
        country = json['country'],
        complement = json['complement'];

  Map<String, dynamic> toJson() => {
        'street': street,
        'number': number,
        'district': district,
        'cityCode': cityCode,
        'city': city,
        'uf': uf,
        'cep': cep,
        'countryCode': countryCode,
        'country': country,
        'complement': complement,
      };

  static empty() => Address(
        cep: '',
        city: '',
        cityCode: 0,
        complement: '',
        country: '',
        countryCode: 0,
        district: '',
        number: '',
        street: '',
        uf: '',
      );
}
