class BranchModel {
  final int id;
  final String name;
  final Map<String, int> tyreStock;

  BranchModel({
    required this.id,
    required this.name,
    required this.tyreStock,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      name: json['name'],
      tyreStock: Map<String, int>.from(json['tyreStock']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tyreStock': tyreStock,
    };
  }
}
