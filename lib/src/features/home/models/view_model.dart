class ViewMoreProduct {
  ViewMoreProduct({
    this.name,
    this.slug,
    this.description,
    this.price,
    this.discount,
    this.brand,
    this.quantity,
    this.condition,
    this.color,
    this.manufactureYear,
    this.document,
    this.returnPolicy,
    this.images,
    this.deliveryType,
  });

  factory ViewMoreProduct.fromJson(Map<String, dynamic> json) =>
      ViewMoreProduct(
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        description: json['description'] as String?,
        price: (json['price'] as num?)?.toDouble(),
        discount: (json['discount'] as num?)?.toDouble(),
        brand: json['brand'] != null
            ? BrandViewMore.fromJson(json['brand'] as Map<String, dynamic>)
            : null,
        quantity: json['quantity'] as int?,
        condition: json['condition'] as String?,
        color: json['color'] as String?,
        manufactureYear: json['manufacture_year'] as int?,
        document: json['document'] as String?,
        returnPolicy: json['return_policy'] as String?,
        images: (json['images'] as List<dynamic>?)
            ?.map((item) => item as String)
            .toList(),
        deliveryType: json['delivery_type'] as String?,
      );

  String? name;
  String? slug;
  String? description;
  double? price;
  double? discount;
  BrandViewMore? brand;
  int? quantity;
  String? condition;
  String? color;
  int? manufactureYear;
  String? document;
  String? returnPolicy;
  List<String>? images;
  String? deliveryType;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'description': description,
        'price': price,
        'discount': discount,
        'brand': brand?.toJson(),
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
    this.name,
    this.slug,
    this.image,
  });

  factory BrandViewMore.fromJson(Map<String, dynamic> json) => BrandViewMore(
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        image: json['image'] as String?,
      );

  String? name;
  String? slug;
  String? image;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'image': image,
      };
}
