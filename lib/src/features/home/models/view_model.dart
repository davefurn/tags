class ViewMoreProduct {
  ViewMoreProduct({
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.discount,
    required this.brand,
    required this.quantity,
    required this.condition,
    required this.color,
    required this.returnPolicy,
    required this.images,
    required this.deliveryType,
    this.manufactureYear,
    this.document,
  });

  factory ViewMoreProduct.fromJson(Map<String, dynamic> json) =>
      ViewMoreProduct(
        name: json['name'],
        slug: json['slug'],
        description: json['description'],
        price: json['price'].toDouble(),
        discount: json['discount'].toDouble(),
        brand: BrandViewMore.fromJson(json['brand']),
        quantity: json['quantity'],
        condition: json['condition'],
        color: json['color'],
        manufactureYear: json['manufacture_year'],
        document: json['document'],
        returnPolicy: json['return_policy'],
        images: List<String>.from(json['images']),
        deliveryType: json['delivery_type'],
      );
  String name;
  String slug;
  String description;
  double price;
  double discount;
  BrandViewMore brand;
  int quantity;
  String condition;
  String color;
  int? manufactureYear;
  String? document;
  String returnPolicy;
  List<String> images;
  String deliveryType;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'description': description,
        'price': price,
        'discount': discount,
        'brand': brand.toJson(),
        'quantity': quantity,
        'condition': condition,
        'color': color,
        'manufacture_year': manufactureYear,
        'document': document,
        'return_policy': returnPolicy,
        'images': images,
        'delivery_type': deliveryType,
      };
}

class BrandViewMore {
  BrandViewMore({
    required this.name,
    required this.slug,
    required this.image,
  });

  factory BrandViewMore.fromJson(Map<String, dynamic> json) => BrandViewMore(
        name: json['name'],
        slug: json['slug'],
        image: json['image'],
      );
  String name;
  String slug;
  String image;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'image': image,
      };
}
