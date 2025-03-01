import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Slkincare extends StatefulWidget {
  const Slkincare({super.key});

  @override
  State<Slkincare> createState() => _SlkincareState();
}

class _SlkincareState extends State<Slkincare> {
  bool isFavorited = false;
  final storage = GetStorage();
  late List favoritesProducts;

  @override
  void initState() {
    super.initState();

    favoritesProducts = List.from(storage.read('Fav_products') ?? []);
    isFavorited = _isProductInFavorites({
      'name': 'Skincare',
      'imageUrl': 'lib/Assets/cosmetic.png',
      'price': '780',
      'quantity': 1,
    });
  }

  bool _isProductInFavorites( product) {
    return favoritesProducts.any((item) => item['name'] == product['name']);
  }

  void toggleFavorite(product) {
    setState(() {
      isFavorited = !isFavorited;

      List favoritesProducts = List.from(storage.read('Fav_products') ?? []);

      bool productExists = favoritesProducts.any((item) => item['name'] == product['name']);

      if (productExists) {
        favoritesProducts.removeWhere((item) => item['name'] == product['name']);
        storage.write('Fav_products', favoritesProducts);
        Get.snackbar('Favorites', 'Removed from Favorites!',
            backgroundColor: Colors.red[300], duration: const Duration(milliseconds: 600));
      } else {
        favoritesProducts.add(product);
        storage.write('Fav_products', favoritesProducts);
        Get.snackbar('Favorites', 'Added to Favorites!',
            backgroundColor: Colors.green[300], duration: const Duration(milliseconds: 800));
      }
    });
  }

  void addProductToCart(Map<String, dynamic> product) {
    List cartProducts = List.from(storage.read('cart_products') ?? []);

    bool productExists = cartProducts.any((item) => item['name'] == product['name']);

    if (productExists) {
      Get.snackbar('Cart', 'Product is already in the cart!',
          backgroundColor: Colors.pink[200], duration: const Duration(milliseconds: 800));
    } else {
      cartProducts.add(product);
      storage.write('cart_products', cartProducts);
      Get.snackbar('Cart', 'Product added successfully!',
          duration: const Duration(milliseconds: 800));
    }
  }

  final List<Color> colorOptions = [
    Colors.black,
    Colors.blueGrey,
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    final product = {
      'name': 'Skincare',
      'imageUrl': 'lib/Assets/cosmetic.png',
      'price': '₹ 780',
      'quantity': 1,
    };

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Skincare',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 30),
                    IconButton(
                      onPressed: () {
                        toggleFavorite(product);
                      },
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  tag: 'Skincare',
                  child: Image.asset(
                    'lib/Assets/cosmetic.png',
                    fit: BoxFit.contain,
                    height: Get.height * 0.4,
                    width: Get.width,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹${product['price']}',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  Row(
                    children: colorOptions.map((color) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundColor: color,
                            radius: 18,
                            child: color == Colors.black ? Icon(Icons.check, color: Colors.white) : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                'Discover the latest skincare with premium ingredients, nourishing formulas, and long-lasting hydration. Experience next-gen skincare with seamless results.',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    addProductToCart(product);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    backgroundColor: Colors.blue,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}