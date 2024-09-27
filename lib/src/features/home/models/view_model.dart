class ViewMoreProduct {
  ViewMoreProduct({
    this.name,
    this.slug,
    this.description,
    this.price,
    this.discount,
    this.discountPrice,
    this.brand,
    this.seller,
    this.category,
    this.quantity,
    this.condition,
    this.color,
    this.manufactureYear,
    this.document,
    this.returnPolicy,
    this.images,
    this.deliveryType,
    this.reviews,
    this.inCart,
  });

  factory ViewMoreProduct.fromJson(Map<String, dynamic> json) =>
      ViewMoreProduct(
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        description: json['description'] as String?,
        price: (json['price'] as num?)?.toDouble(),
        discount: (json['discount'] as num?)?.toDouble(),
        discountPrice: (json['discount_price'] as num?)?.toDouble(),
        brand: json['brand'] != null
            ? BrandViewMore.fromJson(json['brand'] as Map<String, dynamic>)
            : null,
        seller: json['seller'] != null
            ? SellerViewMore.fromJson(json['seller'] as Map<String, dynamic>)
            : null,
        category: json['category'] != null
            ? CategoryViewMore.fromJson(
                json['category'] as Map<String, dynamic>)
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
        reviews: json['reviews'] != null
            ? ReviewsViewMore.fromJson(json['reviews'] as Map<String, dynamic>)
            : null,
        inCart: json['in_cart'] as bool?,
      );

  String? name;
  String? slug;
  String? description;
  double? price;
  double? discount;
  double? discountPrice;
  BrandViewMore? brand;
  SellerViewMore? seller;
  CategoryViewMore? category;
  int? quantity;
  String? condition;
  String? color;
  int? manufactureYear;
  String? document;
  String? returnPolicy;
  List<String>? images;
  String? deliveryType;
  ReviewsViewMore? reviews;
  bool? inCart;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'description': description,
        'price': price,
        'discount': discount,
        'discount_price': discountPrice,
        'brand': brand?.toJson(),
        'seller': seller?.toJson(),
        'category': category?.toJson(),
        'quantity': quantity,
        'condition': condition,
        'color': color,
        'manufacture_year': manufactureYear,
        'document': document,
        'return_policy': returnPolicy,
        'images': images,
        'delivery_type': deliveryType,
        'reviews': reviews?.toJson(),
        'in_cart': inCart,
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

class SellerViewMore {
  SellerViewMore({
    this.name,
    this.slug,
    this.logo,
    this.phone,
    this.email,
    this.stars,
    this.reviews,
  });

  factory SellerViewMore.fromJson(Map<String, dynamic> json) => SellerViewMore(
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        logo: json['logo'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        stars: (json['stars'] as num?)?.toDouble(),
        reviews: json['reviews'] as int?,
      );

  String? name;
  String? slug;
  String? logo;
  String? phone;
  String? email;
  double? stars;
  int? reviews;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'logo': logo,
        'phone': phone,
        'email': email,
        'stars': stars,
        'reviews': reviews,
      };
}

class CategoryViewMore {
  CategoryViewMore({
    this.name,
    this.slug,
    this.subscription,
  });

  factory CategoryViewMore.fromJson(Map<String, dynamic> json) =>
      CategoryViewMore(
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        subscription: json['subscription'] as bool?,
      );

  String? name;
  String? slug;
  bool? subscription;

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'subscription': subscription,
      };
}

class ReviewsViewMore {
  ReviewsViewMore({
    this.rating,
    this.count,
  });

  factory ReviewsViewMore.fromJson(Map<String, dynamic> json) =>
      ReviewsViewMore(
        rating: (json['rating'] as num?)?.toDouble(),
        count: json['count'] as int?,
      );

  double? rating;
  int? count;

  Map<String, dynamic> toJson() => {
        'rating': rating,
        'count': count,
      };
}
