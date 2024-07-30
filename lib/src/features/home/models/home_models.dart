class CategoryModel {
  CategoryModel({required this.image, required this.name});
  String image;
  String name;
}

class DealModel {
  DealModel({
    required this.name,
    required this.image,
    required this.amount,
    required this.category,
  });
  String name;
  String image;
  String amount;
  Category category;
}

class MessageModel {
  // Category category;

  MessageModel({
    required this.storename,
    required this.image,
    required this.message,
    required this.time,
  });
  String storename;
  String image;
  String message;
  String time;
}

class ProfileModel {
  ProfileModel({
    required this.image,
    required this.title,
    this.action,
  });
  String image;
  String title;
  final void Function()? action;
}

enum Category { cars, phones, bestSelling }

List<CategoryModel> topCategories = [
  CategoryModel(image: 'assets/images/cars_category.png', name: 'Cars'),
  CategoryModel(
    image: 'assets/images/phone_category.png',
    name: 'Phones & Tablet',
  ),
  CategoryModel(
    image: 'assets/images/electronics_category.png',
    name: 'Electronics',
  ),
];

List<DealModel> deals = [
  DealModel(
    name: 'Smart TV',
    image: 'assets/images/smart_tv_deal.png',
    amount: r'$707,600',
    category: Category.bestSelling,
  ),
  DealModel(
    name: 'Iphone 13 pro Max',
    image: 'assets/images/phone_category.png',
    amount: r'$707,600',
    category: Category.bestSelling,
  ),
  DealModel(
    name: 'LG Air Conditioner',
    image: 'assets/images/air_conditioner_deal.png',
    amount: r'$707,600',
    category: Category.bestSelling,
  ),
  DealModel(
    name: 'Cream',
    image: 'assets/images/cream_deal.png',
    amount: r'$707,600',
    category: Category.bestSelling,
  ),
  DealModel(
    name: 'Diamond Ring',
    image: 'assets/images/diamond_ring.png',
    amount: r'$707,600',
    category: Category.bestSelling,
  ),
  DealModel(
    name: 'Cars',
    image: 'assets/images/cars_deal.png',
    amount: r'$707,600',
    category: Category.cars,
  ),
  DealModel(
    name: 'Cars',
    image: 'assets/images/cars_deal.png',
    amount: r'$707,600',
    category: Category.cars,
  ),
  DealModel(
    name: 'Cars',
    image: 'assets/images/cars_deal.png',
    amount: r'$707,600',
    category: Category.cars,
  ),
  DealModel(
    name: 'Cars',
    image: 'assets/images/cars_deal.png',
    amount: r'$707,600',
    category: Category.cars,
  ),
  DealModel(
    name: 'Cars',
    image: 'assets/images/cars_deal.png',
    amount: r'$707,600',
    category: Category.cars,
  ),
  DealModel(
    name: 'Phones',
    image: 'assets/images/phones_deal.png',
    amount: r'$707,600',
    category: Category.phones,
  ),
  DealModel(
    name: 'Phones',
    image: 'assets/images/phones_deal.png',
    amount: r'$707,600',
    category: Category.phones,
  ),
  DealModel(
    name: 'Phones',
    image: 'assets/images/phones_deal.png',
    amount: r'$707,600',
    category: Category.phones,
  ),
  DealModel(
    name: 'Phones',
    image: 'assets/images/phones_deal.png',
    amount: r'$707,600',
    category: Category.phones,
  ),
  DealModel(
    name: 'Phones',
    image: 'assets/images/phones_deal.png',
    amount: r'$707,600',
    category: Category.phones,
  ),
  DealModel(
    name: 'Phones',
    image: 'assets/images/phones_deal.png',
    amount: r'$707,600',
    category: Category.phones,
  ),
];

//message list
List<MessageModel> msg = [
  MessageModel(
    image: 'assets/images/smart_tv_deal.png',
    storename: 'Star Labs Market',
    message: 'How many flash custome do you have ?',
    time: '2:35 pm',
  ),
  MessageModel(
    image: 'assets/images/smart_tv_deal.png',
    storename: '12 Baskets Market',
    message: 'How many baskets are left ?',
    time: '2:35 pm',
  ),
  MessageModel(
    image: 'assets/images/smart_tv_deal.png',
    storename: 'Tags Market',
    message: 'Do you have this iPhone 15 pro available ?',
    time: '2:35 pm',
  ),
];

//profiel

List<DealModel> phoneDeals =
    deals.where((element) => element.category == Category.phones).toList();

List<DealModel> carDeals =
    deals.where((element) => element.category == Category.cars).toList();

List<DealModel> bestSellingDeals =
    deals.where((element) => element.category == Category.bestSelling).toList();

List<MessageModel> myMessages = msg;
// List<ProfileModel> mydetails = myProfile;
