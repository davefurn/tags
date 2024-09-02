// ignore_for_file: avoid_dynamic_calls

import 'package:intl/intl.dart';

class ResultModel {
  ResultModel({
    required this.name,
    required this.slug,
  });
  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        name: json['name'] ?? '',
        slug: json['slug'] ?? '',
      );

  final String? name;
  final String? slug;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
      };
}

class PopularCategoriz {
  PopularCategoriz({
    required this.name,
    required this.slug,
    required this.image,
  });
  factory PopularCategoriz.fromJson(Map<String, dynamic> json) =>
      PopularCategoriz(
        name: json['name'] ?? '',
        slug: json['slug'] ?? '',
        image: json['image'] ?? '',
      );

  final String name;
  final String slug;
  final String image;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'image': image,
      };
}

class TodayDeal {
  TodayDeal({
    required this.product,
    required this.slug,
    required this.price,
    required this.currency,
    required this.discount,
    required this.discountedPrice,
    required this.image,
    required this.tagOne,
  });

  factory TodayDeal.fromJson(Map<String, dynamic> json) => TodayDeal(
        product: json['product'],
        slug: json['slug'],
        price: json['price'],
        currency: json['currency'],
        discount: json['discount'],
        discountedPrice: json['discounted_price'],
        image: json['image'],
        tagOne: json['tag_one'],
      );
  String product;
  String slug;
  double price;
  String currency;
  double discount;
  double discountedPrice;
  String image;
  bool tagOne;

  Map<String, dynamic> toJson() => {
        'product': product,
        'slug': slug,
        'price': price,
        'currency': currency,
        'discount': discount,
        'discounted_price': discountedPrice,
        'image': image,
        'tag_one': tagOne,
      };

  String get formattedPrice {
    final format = NumberFormat('#,##0.00', 'en_US');
    return format.format(price);
  }

  String get formattedDiscountedPrice {
    final format = NumberFormat('#,##0.00', 'en_US');
    return format.format(discountedPrice);
  }
}

class BestSellingModel {
  BestSellingModel({
    required this.product,
    required this.slug,
    required this.price,
    required this.currency,
    required this.image,
    required this.tagOne,
  });
  factory BestSellingModel.fromJson(Map<String, dynamic> json) =>
      BestSellingModel(
        product: json['product'],
        slug: json['slug'],
        price: json['price'],
        currency: json['currency'],
        image: json['image'],
        tagOne: json['tag_one'],
      );
  String product;
  String slug;
  double price;
  String currency;
  String image;
  bool tagOne;

  Map<String, dynamic> toJson() => {
        'product': product,
        'slug': slug,
        'price': price,
        'currency': currency,
        'image': image,
        'tag_one': tagOne,
      };
}

class AllCategoriesModel {
  AllCategoriesModel({
    required this.name,
    required this.slug,
    required this.products,
  });
  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) =>
      AllCategoriesModel(
        name: json['name'] ?? '',
        slug: json['slug'] ?? '',
        products: json['products'] == null
            ? []
            : List<Product>.from(
                json['products']!.map((x) => Product.fromJson(x)),
              ),
      );

  final String name;
  final String slug;
  final List<Product> products;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'products': products.map((x) => x.toJson()).toList(),
      };
}

class Product {
  Product({
    required this.name,
    required this.slug,
    required this.image,
    required this.price,
    required this.currency,
    required this.priceString,
    required this.discount,
    required this.discountedPrice,
    required this.discountedPriceString,
  });
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'] ?? '',
        slug: json['slug'] ?? '',
        image: json['image'] ?? '',
        // price: json["price"] ?? 0,
        price: json['price'].toDouble(), // Ensure it's parsed as double

        currency: json['currency'] ?? '',
        priceString: json['price_string'] ?? '',
        discount: json['discount'].toDouble(),
        discountedPrice: json['discounted_price'].toDouble(),
        discountedPriceString: json['discounted_price_string'] ?? '',
      );

  final String name;
  final String slug;
  final String image;
  final double price;
  final String currency;
  final String priceString;
  final double discount;
  final double discountedPrice;
  final String discountedPriceString;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'image': image,
        'price': price,
        'currency': currency,
        'price_string': priceString,
        'discount': discount,
        'discounted_price': discountedPrice,
        'discounted_price_string': discountedPriceString,
      };
}

//
class CompanyModel {
  CompanyModel({
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.categories,
    required this.logo,
    required this.cover,
    required this.currency,
    required this.deliveryPlan,
  });
  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        companyName: json['company_name'] ?? '',
        companyEmail: json['company_email'] ?? '',
        companyPhone: json['company_phone'] ?? '',
        categories: json['categories'] == null
            ? []
            : List<String>.from(json['categories']!.map((x) => x)),
        logo: json['logo'],
        cover: json['cover'],
        currency: json['currency'] ?? '',
        deliveryPlan: json['delivery_plan'] ?? '',
      );

  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final List<String> categories;
  final dynamic logo;
  final dynamic cover;
  final String currency;
  final String deliveryPlan;

  Map<String, dynamic> toJson() => {
        'company_name': companyName,
        'company_email': companyEmail,
        'company_phone': companyPhone,
        'categories': categories.map((x) => x).toList(),
        'logo': logo,
        'cover': cover,
        'currency': currency,
        'delivery_plan': deliveryPlan,
      };
}

//
class Brand {
  Brand({
    required this.name,
    required this.slug,
    required this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        name: json['name'],
        slug: json['slug'],
        image: json['image'],
      );
  final String name;
  final String slug;
  final String image;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'image': image,
      };
}
//

class BrandProduct {
  BrandProduct({
    required this.name,
    required this.slug,
    required this.image,
    required this.price,
    required this.currency,
    required this.discount,
    required this.discountedPrice,
    required this.tagOne,
  });

  factory BrandProduct.fromJson(Map<String, dynamic> json) => BrandProduct(
        name: json['name'],
        slug: json['slug'],
        image: json['image'],
        price: json['price'].toDouble(),
        currency: json['currency'],
        discount: json['discount'].toDouble(),
        discountedPrice: json['discounted_price'].toDouble(),
        tagOne: json['tag_one'],
      );
  final String name;
  final String slug;
  final String image;
  final double price;
  final String currency;
  final double discount;
  final double discountedPrice;
  final bool tagOne;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'image': image,
        'price': price,
        'currency': currency,
        'discount': discount,
        'discounted_price': discountedPrice,
        'tag_one': tagOne,
      };
}

class CartProducts {
  CartProducts({
    this.name,
    this.slug,
    this.image,
    this.price,
    this.discountedPrice,
    this.brand,
    this.color,
    this.quantity,
  });
  final String? name;
  final String? slug;
  final String? image;
  final double? price;
  final double? discountedPrice;
  final String? brand;
  final String? color;
  final int? quantity;

  // Factory method to create an instance from a JSON object
  factory CartProducts.fromJson(Map<String, dynamic> json) => CartProducts(
        name: json['name'] ?? '',
        slug: json['slug'] ?? '',
        image: json['image'] ?? '',
        price: json['price'] is String
            ? double.tryParse(json['price']) ?? 0.0
            : json['price'] ?? 0.0,
        discountedPrice: json['discounted_price'] is String
            ? double.tryParse(json['discounted_price']) ?? 0.0
            : json['discounted_price'] ?? 0.0,
        brand: json['brand'] ?? '',
        color: json['color'] ?? '',
        quantity: json['quantity'] ?? 0,
      );

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() => {
        'name': name ?? '',
        'slug': slug ?? '',
        'image': image ?? '',
        'price': price?.toString() ?? '0.0',
        'discounted_price': discountedPrice?.toString() ?? '0.0',
        'brand': brand ?? '',
        'color': color ?? '',
        'quantity': quantity ?? 0,
      };
}
