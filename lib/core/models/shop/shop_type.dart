class ShopType {
  final int id;
  final String name;

  ShopType(this.id, {this.name});

  static ShopType fromMap(Map<String, dynamic> map) {
    return ShopType(
      map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }
}
