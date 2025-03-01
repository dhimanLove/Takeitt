import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takeittt/components/mydrawer.dart';
import 'package:takeittt/components/searchdelegate.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final storage = GetStorage();
  late List cartProducts;
  late List favoritesProducts;

  @override
  void initState() {
    super.initState();
    cartProducts = List.from(storage.read('cart_products') ?? []);
    favoritesProducts = List.from(storage.read('Fav_products') ?? []);
  }

  void removeFromWishlist(int index) {
    setState(() {
      favoritesProducts.removeAt(index);
      storage.write('Fav_products', favoritesProducts);
      Get.snackbar(
        'Favorites',
        'Removed from Favorites',
        backgroundColor: Colors.red[200],
        duration: const Duration(milliseconds: 800),
      );
    });
  }

  int calculateTotalPrice(List products) {
    return products.fold(0, (sum, item) {
      String priceStr = item['price']?.toString().replaceAll(RegExp(r'[^\d]'), '') ?? '0';
      int price = int.tryParse(priceStr) ?? 0;
      int quantity = int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;
      return sum + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = calculateTotalPrice(cartProducts);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: Icon(Icons.menu, color: Colors.white)),
        title: Text("Cart", style: TextStyle(color: Colors.white, fontSize: 22)),
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: MySearchDelegate()),
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.mic, color: Colors.white)),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Favorites (Wishlist) Section
                  Container(
                    width: Get.width,
                    // Removed fixed height to allow dynamic content
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wishlist',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        favoritesProducts.isNotEmpty
                            ? SizedBox(
                          // Use SizedBox with a constrained height to prevent overflow
                          height: Get.height * 0.45, // Adjusted height to fit within the screen
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: favoritesProducts.length,
                            itemBuilder: (context, index) {
                              var product = favoritesProducts[index];
                              return Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Stack(
                                    children: [
                                      // Main content (image, text, and button)
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Product Image
                                          ClipRRect(
                                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                                            child: product['imageUrl']?.startsWith('http') ?? false
                                                ? Image.network(
                                              product['imageUrl']!,
                                              fit: BoxFit.cover,
                                              height: 120,
                                              width: 80,
                                              loadingBuilder: (context, child, loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return const Center(child: CircularProgressIndicator());
                                              },
                                            )
                                                : Image.asset(
                                              product['imageUrl'] ?? 'assets/images/placeholder.png',
                                              fit: BoxFit.cover,
                                              height: 120,
                                              width: 80,
                                            ),
                                          ),
                                          // Product Details and Button
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    product['name'] ?? 'Product',
                                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    '\$${product['price'] ?? '0'}',
                                                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.green),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Optional: Add to cart when "Shop Now" is pressed
                                                      final cartProduct = {
                                                        'name': product['name'],
                                                        'price': product['price'],
                                                        'imageUrl': product['imageUrl'],
                                                        'quantity': 1, // Default quantity
                                                      };
                                                      addProductToCart(cartProduct);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.yellow.shade700,
                                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Shop Now',
                                                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Favorite Icon (for removal from wishlist)
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: IconButton(
                                          onPressed: () {
                                            removeFromWishlist(index);
                                          },
                                          icon: const Icon(Icons.favorite, color: Colors.red),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                            : Center(
                          child: Text(
                            'Your wishlist is empty ❤️',
                            style: GoogleFonts.poppins(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Cart Section (unchanged)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cart',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        cartProducts.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
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
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (product['name'] ?? 'Product Name').toString(),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                product['price']?.toString() ?? 'Price not available',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 20,
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
                                                      backgroundColor: Colors.red[200],
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
                            'Your cart is empty 🛒',
                            style: GoogleFonts.poppins(fontSize: 20, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),

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
                          Text(
                            'Proceed to Buy',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Total: ₹$totalPrice',
                            style: GoogleFonts.poppins(
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
}