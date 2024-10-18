import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class OrderData {
  OrderData({
    required this.orderId,
    required this.products,
    required this.total,
    required this.currency,
    required this.address,
    required this.instructions,
  });

  // Create OrderData from JSON
  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        orderId: json['order_id'] ?? '', // Default to empty string if null
        products: (json['products'] as List<dynamic>?)
                ?.map((productJson) => Productive.fromJson(productJson))
                .toList() ??
            [], // Default to empty list if null
        total: (json['total'] as num?)?.toDouble() ??
            0.0, // Default to 0.0 if null
        currency: json['currency'] ?? '', // Default to empty string if null
        address: json['address'] ?? '', // Default to empty string if null
        instructions: json['instructions'], // Allow null for instructions
      );

  final String orderId;
  final List<Productive> products;
  final double total;
  final String currency;
  final String address;
  final String? instructions; // Can be null

  // Convert OrderData to JSON
  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'products': products.map((product) => product.toJson()).toList(),
        'total': total,
        'currency': currency,
        'address': address,
        'instructions': instructions, // Can be null
      };
}

class Productive {
  Productive({
    required this.name,
    required this.slug,
    required this.image,
    required this.price,
    required this.currency,
    required this.brand,
    required this.color,
    required this.quantity,
  });

  // Create Product from JSON
  factory Productive.fromJson(Map<String, dynamic> json) => Productive(
        name: json['name'] ?? '', // Default to empty string if null
        slug: json['slug'] ?? '', // Default to empty string if null
        image: json['image'] ?? '', // Default to empty string if null
        price: (json['price'] as num?)?.toDouble() ??
            0.0, // Default to 0.0 if null
        currency: json['currency'] ?? '', // Default to empty string if null
        brand: json['brand'] ?? '', // Default to empty string if null
        color: json['color'] != null && json['color'] is String
            ? json['color']
            : '', // Default to empty list if null
        quantity: json['quantity'] ?? 0, // Default to 0 if null
      );

  final String name;
  final String slug;
  final String image;
  final double price;
  final String currency;
  final String brand;
  final String color;
  final int quantity;

  // Convert Product to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'image': image,
        'price': price,
        'currency': currency,
        'brand': brand,
        'color': color,
        'quantity': quantity,
      };
}

Future<OrderData?> getOrder() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? orderJson = prefs.getString(
    'orderData',
  ); // Retrieve the JSON string

  if (orderJson != null) {
    Map<String, dynamic> orderMap = jsonDecode(
      orderJson,
    ); // Convert JSON string back to Map
    return OrderData.fromJson(
      orderMap,
    ); // Convert Map to OrderData
  }

  return null; // Return null if no data is found
}

Future<void> saveOrder(OrderData order) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String orderJson = jsonEncode(order.toJson()); // Convert the model to JSON
  await prefs.setString(
    'orderData',
    orderJson,
  ); // Save the JSON to SharedPreferences
}
