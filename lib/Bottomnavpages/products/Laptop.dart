import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Laptop extends StatefulWidget {
  const Laptop({super.key});

  @override
  State<Laptop> createState() => _LaptopState();
}

class _LaptopState extends State<Laptop> {
  bool isclicked = false;
  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    isclicked = _isProductInFavorites({
      'name': 'The MacBook M3 ',
      'imageUrl': '',
      'price': '₹78000/-',
      'quantity': 1,
    });
  }

  bool _isProductInFavorites( product) {
    List favoritesProducts =
        List.from(storage.read('Fav_products') ?? []);
    return favoritesProducts.any((item) => item['name'] == product['name']);
  }

  void toggleFavourite( product) {
    List favoritesProducts =
        List.from(storage.read('Fav_products') ?? []);

    bool productExists =
        favoritesProducts.any((item) => item['name'] == product['name']);

    if (productExists) {
      favoritesProducts.removeWhere((item) => item['name'] == product['name']);
      storage.write('Fav_products', favoritesProducts);
      Get.snackbar('Favourites', 'Removed from Favourites!',
          backgroundColor: Colors.red[200],
          duration: const Duration(milliseconds: 800));
      setState(() {
        isclicked = false;
      });
    } else {
      favoritesProducts.add(product);
      storage.write('Fav_products', favoritesProducts);
      Get.snackbar('Favourites', 'Added to Favourites!',
          backgroundColor: Colors.green[200],
          duration: const Duration(milliseconds: 800));
      setState(() {
        isclicked = true;
      });
    }
  }

  void addProductToCart(product) {
    List cartProducts = List.from(storage.read('cart_products') ?? []);

    bool productExists =
        cartProducts.any((item) => item['name'] == product['name']);

    if (productExists) {
      Get.snackbar('Cart', 'Product is already in the cart!',
          backgroundColor: Colors.pink[200],
          duration: const Duration(milliseconds: 800));
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
      'name': 'The MacBook M3 ',
      'imageUrl': 'lib/Assets/mac.png',
      'price': '₹ 78000/-',
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
                    const Text(
                      'Laptop',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 30),
                    IconButton(
                      onPressed: () {
                        toggleFavourite(product);
                      },
                      icon: Icon(
                        isclicked ? Icons.favorite : Icons.favorite_border,
                        color: isclicked ? Colors.red : Colors.grey,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: 'laptop',
                    child: Image.asset(
                      'lib/Assets/mac.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$999',
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
                            child: color == Colors.black
                                ? const Icon(Icons.check, color: Colors.white)
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                'Discover the latest Laptop with a high-resolution OLED display, powerful processor, and long-lasting battery life. Experience next-gen performance with seamless multitasking.',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
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
                  child: const Text(
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
