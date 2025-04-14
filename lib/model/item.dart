class Item {
  final String title;
  final String image;
  final String restaurant;
  final double price;

  Item({
    required this.title,
    required this.image,
    required this.restaurant,
    required this.price,
  });
}

final List<Item> items = [
  Item(
    title: "Chicken Burger",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/chickenBurger.png",
    restaurant: 'Hot Cool Spot',
    price: 20.00,
  ),
  Item(
    title: "Cheese Burger",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/cheseBurger.png",
    restaurant: 'Burger Factory LTD',
    price: 15.00,
  ),
  Item(
    title: "Pepperoni Pizza",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/pepperoniPizza.png",
    restaurant: 'Pizza Palace',
    price: 29.00,
  ),
  Item(
    title: "Cheese Pizza",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/pizzaCheese.png",
    restaurant: 'Hot Cool Spot',
    price: 23.00,
  ),
];
