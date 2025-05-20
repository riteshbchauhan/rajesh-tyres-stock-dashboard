class TyreModel {
  final int id;
  final String name;
  final String company;
  final double price;
  int quantity;

  TyreModel({
    required this.id,
    required this.name,
    required this.company,
    required this.price,
    required this.quantity,
  });

  factory TyreModel.fromJson(Map<String, dynamic> json) {
    return TyreModel(
      id: json['id'],
      name: json['name'],
      company: json['company'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'company': company,
      'price': price,
      'quantity': quantity,
    };
  }
}
