class ShopLabel {
  final int id;
  final String name;

  ShopLabel(this.id, {this.name});

  static ShopLabel fromMap(Map<String, dynamic> map) {
    return ShopLabel(
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
