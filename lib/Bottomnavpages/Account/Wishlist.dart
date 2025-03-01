import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final storage = GetStorage();
  List wishlistItems = []; // Remove 'late' and initialize with empty list

  @override
  void initState() {
    super.initState();
    // Load wishlist items from storage when the widget initializes
    wishlistItems = List.from(storage.read('Fav_products') ?? []);
  }

  void removeFromWishlist(int index) {
    setState(() {
      wishlistItems.removeAt(index);
      storage.write('Fav_products', wishlistItems);
      Get.snackbar(
        'Wishlist',
        'Removed from Wishlist',
        backgroundColor: Colors.red[200],
        duration: const Duration(milliseconds: 800),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: wishlistItems.isNotEmpty
          ? ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          var product = wishlistItems[index];
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
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
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
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          removeFromWishlist(index);
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
          : Center(
        child: Text(
          'Your Wishlist is Empty 🛒',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }
}