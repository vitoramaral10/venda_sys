class Product {
  String? id;
  String code;
  String description;
  String resumedDescription;
  int quantity;
  double? buyingPrice;
  double? sellingPrice;
  String ncm;
  String unitOfMeasurement;

  Product({
    this.id,
    required this.code,
    required this.description,
    required this.resumedDescription,
    required this.quantity,
    this.buyingPrice,
    this.sellingPrice,
    required this.ncm,
    required this.unitOfMeasurement,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        description = json['description'],
        resumedDescription = json['resumedDescription'],
        quantity = json['quantity'],
        buyingPrice = json['buyingPrice'],
        sellingPrice = json['sellingPrice'],
        ncm = json['ncm'],
        unitOfMeasurement = json['unitOfMeasurement'];

  Map<String, dynamic> toJson() => {
        'code': code,
        'description': description,
        'resumedDescription': resumedDescription,
        'quantity': quantity,
        'buyingPrice': buyingPrice,
        'sellingPrice': sellingPrice,
        'ncm': ncm,
        'unitOfMeasurement': unitOfMeasurement,
      };
}
