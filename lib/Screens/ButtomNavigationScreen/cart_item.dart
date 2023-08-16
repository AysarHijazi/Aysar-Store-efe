class CartItem {
  final String name;
  final double price;

  CartItem({
    required this.name,
    required this.price,
  });

  // Convert CartItem data to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}
