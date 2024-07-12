// ignore_for_file: avoid_dynamic_calls

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

class TodayModel {
  TodayModel({
    required this.product,
    required this.slug,
    required this.price,
    required this.currency,
    required this.priceString,
    required this.discount,
    required this.discountedPrice,
    required this.discountedPriceString,
    required this.image,
  });
  factory TodayModel.fromJson(Map<String, dynamic> json) => TodayModel(
        product: json['product'] ?? '',
        slug: json['slug'] ?? '',
        price: json['price'].toDouble(),
        currency: json['currency'] ?? '',
        priceString: json['price_string'] ?? '',
        discount: json['discount'].toDouble(),
        discountedPrice: json['discounted_price'].toDouble(),
        discountedPriceString: json['discounted_price_string'] ?? '',
        image: json['image'] ?? '',
      );

  final String product;
  final String slug;
  final double price;
  final String currency;
  final String priceString;
  final double discount;
  final double discountedPrice;
  final String discountedPriceString;
  final String image;

  Map<String, dynamic> toJson() => {
        'product': product,
        'slug': slug,
        'price': price,
        'currency': currency,
        'price_string': priceString,
        'discount': discount,
        'discounted_price': discountedPrice,
        'discounted_price_string': discountedPriceString,
        'image': image,
      };
}

class BestSellingModel {
  BestSellingModel({
    required this.product,
    required this.slug,
    required this.price,
    required this.currency,
    required this.priceString,
    required this.image,
  });
  factory BestSellingModel.fromJson(Map<String, dynamic> json) =>
      BestSellingModel(
        product: json['product'] ?? '',
        slug: json['slug'] ?? '',
        price: json['price'].toDouble(),
        currency: json['currency'] ?? '',
        priceString: json['price_string'] ?? '',
        image: json['image'] ?? '',
      );

  final String product;
  final String slug;
  final double price;
  final String currency;
  final String priceString;
  final String image;

  Map<String, dynamic> toJson() => {
        'product': product,
        'slug': slug,
        'price': price,
        'currency': currency,
        'price_string': priceString,
        'image': image,
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
                json['products']!.map((x) => Product.fromJson(x))),
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
