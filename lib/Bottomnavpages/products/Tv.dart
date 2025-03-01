import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Tv extends StatefulWidget {
  const Tv({super.key});

  @override
  State<Tv> createState() => _TvState();
}

class _TvState extends State<Tv> {
  bool isFavorited = false; // Track favorite state
  final storage = GetStorage();
  late List favoritesProducts; // List for favorites

  @override
  void initState() {
    super.initState();
    // Initialize favorites list from storage
    favoritesProducts = List.from(storage.read('Fav_products') ?? []);
    // Check if the product is already in favorites
    isFavorited = _isProductInFavorites({
      'name': 'Samsung LCD',
      'imageUrl': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/462a73798c40c255812e19897c08f9831a88c4f0',
      'price': '1200', // Updated to match the UI price
      'quantity': 1,
    });
  }

  bool _isProductInFavorites(Map<String, dynamic> product) {
    return favoritesProducts.any((item) => item['name'] == product['name']);
  }

  void toggleFavorite(Map<String, dynamic> product) {
    setState(() {
      isFavorited = !isFavorited;

      List favoritesProducts = List.from(storage.read('Fav_products') ?? []);

      bool productExists = favoritesProducts.any((item) => item['name'] == product['name']);

      if (productExists) {
        favoritesProducts.removeWhere((item) => item['name'] == product['name']);
        storage.write('Fav_products', favoritesProducts);
        Get.snackbar('Favorites', 'Removed from Favorites!',
            backgroundColor: Colors.red[200], duration: const Duration(milliseconds: 800));
      } else {
        favoritesProducts.add(product);
        storage.write('Fav_products', favoritesProducts);
        Get.snackbar('Favorites', 'Added to Favorites!',
            backgroundColor: Colors.green[200], duration: const Duration(milliseconds: 800));
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
      'name': 'Samsung LCD',
      'imageUrl': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/462a73798c40c255812e19897c08f9831a88c4f0',
      'price': '1200',
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
                      'Samsung LCD',
                      style: TextStyle(
                        fontSize: 30,
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
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: 'Tv',
                  child: Image.network(
                    'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/462a73798c40c255812e19897c08f9831a88c4f0',
                    fit: BoxFit.cover,
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
                    '\$${product['price']}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Row(
                    children: colorOptions.map((color) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          backgroundColor: color,
                          radius: 12,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Experience the best quality Smart TV with 4K resolution, HDR support, and Dolby Atmos sound. Enjoy seamless streaming and gaming with ultra-fast processing.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[900],
                ),
                textAlign: TextAlign.center,
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