// home screen data still needs work
import '../../model/category.dart';

final List<Category> items = [
  Category(
    title: "Chicken Sandwich",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/cheseBurger.png",
    description: "100 gr chicken + tomato + cheese + Lettuce",
    price: "\$20.00",
    rating: 0,
    id: 1,
  ),
  Category(
    title: "Cheese Sandwich",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/pepperoniPizza.png",
    description: "lzzhxcskldbvkj'adljjsvh",
    price: "\$15.00",
    rating: 0,
    id: 2,
  ),
  Category(
    title: "Hot dog Sandwich",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/pizzaCheese.png",
    description: "lhuvhjn,kjbhvgb.akhuj",
    price: "\$15.00",
    rating: 0,
    id: 3,
  ),
  Category(
    title: "Pepperoni Pizza",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/pepperoniPizza.png",
    description: "Classic Italian Pepperoni Pizza",
    price: "\$29.00",
    rating: 0,
    id: 4,
  ),
  Category(
    title: "Cheese Pizza",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/pizzaCheese.png",
    description: "Margarita-style pizza with fresh mozzarella",
    price: "\$23.00",
    rating: 0,
    id: 5,
  ),
  Category(
    title: "Mexican Green Pizza",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/mexicanGreenWave.png",
    description:
        "A pizza loaded with crunchy onions, crisp capsicum, juicy tomatoes",
    price: "\$23.00",
    rating: 0,
    id: 6,
  ),
  Category(
    title: "Peppy Paneer Pizza",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/peppyPaneer.png",
    description: "Chunky paneer with crisp capsicum and spicy red pepper",
    price: "\$13.00",
    rating: 0,
    id: 7,
  ),
];

// Top Rated Items
final List<Category> topRatedItems = [
  Category(
    title: "Chicken Burger",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/chickenBurger.png",
    description: "100 gr chicken + tomato + cheese Lettuce",
    price: "\$20.00",
    rating: 3.8,
    id: 1,
  ),
  Category(
    title: "Cheese Burger",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/cheseBurger.png",
    description: "100 gr meat + onion + tomato + Lettuce cheese",
    price: "\$15.00",
    rating: 4.5,
    id: 2,
  ),
  Category(
    title: "Spicy Chicken Burger",
    image:
        "assets/images/mainPage/home_page_images/top_rated_list_images/cheseBurger.png",
    description: "100 gr spicy chicken + tomato + cheese + Lettuce",
    price: "\$20.00",
    rating: 3.9,
    id: 11,
  ),
];

// Recommended Items
final List<Category> recommendedItems = [
  Category(
    title: "Sushi Platter",
    image: "assets/images/mainPage/home_page_images/recommend_images/sushi.png",
    description: "",
    price: "\$103.00",
    rating: 0,
    id: 10,
  ),
  Category(
    title: "Curry",
    image: "assets/images/mainPage/home_page_images/recommend_images/curry.png",
    description: "",
    price: "\$50.0",
    rating: 0,
    id: 22,
  ),
  Category(
    title: "Grilled Steak",
    image: "assets/images/mainPage/home_page_images/recommend_images/pasta.png",
    description: "",
    price: "\$12.99",
    rating: 0,
    id:25,
  ),
  Category(
    title: "Cupcake",
    image:
        "assets/images/mainPage/home_page_images/recommend_images/cupcake.png",
    description: "",
    price: "\$8.20",
    rating: 0,
    id: 27,
  ),
];

// Categories
final List<String> categories = ["All", "Burger", "Pizza", "Sandwich"];
String selectedCategory = "All";

// Unified List of All Items
final List<Category> allItems = [
  ...topRatedItems,
  ...recommendedItems,
  ...items,
];
