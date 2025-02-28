import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    List cartProducts = storage.read('cart_products') ?? [];
    List favoritesProducts = storage.read('Fav_products') ?? [];

    // Calculate total price for cart
    int totalPrice = cartProducts.fold(0, (sum, item) {
      String priceStr = item['price']?.toString().replaceAll(RegExp(r'[^\d]'), '') ?? '0';
      int price = int.tryParse(priceStr) ?? 0;
      int quantity = int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      return sum + (price * quantity);
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Favorites Section in the Container
                  Container(
                    width: Get.width,
                    height: Get.height * 0.4,
                    color: Colors.grey[300],
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Favorites',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        favoritesProducts.isNotEmpty
                            ? SizedBox(
                          height: Get.height * 0.3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: favoritesProducts.length,
                            itemBuilder: (context, index) {
                              var product = favoritesProducts[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: product['imageUrl']?.startsWith('http') ?? false
                                              ? Image.network(
                                            product['imageUrl']!,
                                            fit: BoxFit.cover,
                                            height: Get.height * 0.2,
                                            width: Get.width * 0.3,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return const Center(child: CircularProgressIndicator());
                                            },
                                          )
                                              : Image.asset(
                                            product['imageUrl'] ?? 'assets/images/placeholder.png',
                                            fit: BoxFit.cover,
                                            height: Get.height * 0.2,
                                            width: Get.width * 0.3,
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                favoritesProducts.removeAt(index);
                                                storage.write('Fav_products', favoritesProducts);
                                                Get.snackbar(
                                                  'Favorites',
                                                  'Removed from favorites',
                                                  duration: const Duration(milliseconds: 800),
                                                );
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      (product['name'] ?? 'Product Name').toString(),
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      product['price']?.toString() ?? 'N/A',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                            : const Center(
                          child: Text(
                            'Your favorites list is empty ❤️',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Cart Section Below
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cart',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        cartProducts.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartProducts.length,
                          itemBuilder: (context, index) {
                            var product = cartProducts[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Hot Deal',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: product['imageUrl']?.startsWith('http') ?? false
                                                  ? Image.network(
                                                product['imageUrl']!,
                                                fit: BoxFit.cover,
                                                height: Get.height * 0.1,
                                                width: Get.width * 0.2,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return const Center(child: CircularProgressIndicator());
                                                },
                                              )
                                                  : Image.asset(
                                                product['imageUrl'] ?? 'assets/images/placeholder.png',
                                                fit: BoxFit.cover,
                                                height: Get.height * 0.1,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      int currentQuantity = int.tryParse(product['quantity']?.toString() ?? '1') ?? 1;
                                                      if (currentQuantity > 1) {
                                                        product['quantity'] = currentQuantity - 1;
                                                        storage.write('cart_products', cartProducts);
                                                      }
                                                    });
                                                  },
                                                  icon: const Icon(Icons.remove, color: Colors.red),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black38),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Text(
                                                    product['quantity'].toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      int currentQuantity = int.tryParse(product['quantity']?.toString() ?? '1') ?? 1;
                                                      product['quantity'] = currentQuantity + 1;
                                                      storage.write('cart_products', cartProducts);
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add, color: Colors.green),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                (product['name'] ?? 'Product Name').toString(),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              product['price']?.toString() ?? 'Price not available',
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  cartProducts.removeAt(index);
                                                  storage.write('cart_products', cartProducts);
                                                  Get.snackbar(
                                                    'Cart',
                                                    'Removed from cart',
                                                    duration: const Duration(milliseconds: 800),
                                                  );
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                            : const Center(
                          child: Text(
                            'Your cart is empty 🛒',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80), // Space for the Proceed to Buy button
                ],
              ),
            ),

            // Proceed to Buy Button (Cart only)
            if (cartProducts.isNotEmpty)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orangeAccent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Proceed to Buy',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Total: ₹$totalPrice',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}