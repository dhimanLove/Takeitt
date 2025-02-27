import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    List cartProducts = storage.read ('cart_products') ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: cartProducts.isNotEmpty
          ? ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          var product = cartProducts[index];

          return
            Card(
              margin: EdgeInsets.all(15),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: Get.height * 0.2,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: product['imageUrl']?.startsWith('http') ?? false
                          ? Image.network(
                        product['imageUrl']!,
                        fit: BoxFit.cover,
                        height: Get.height * 0.1,
                        width: Get.width * 0.2,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                      )
                          : Image.asset(
                        product['imageUrl'] ?? 'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                        height: Get.height * 0.1,
                      ),
                    ),
                    SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'] ?? 'Product Name',
                            style: GoogleFonts.ubuntu(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            product['price']?.toString() ?? 'Price not available',
                            style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.green[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              cartProducts.removeAt(index);
                              storage.write('cart_products', cartProducts);
                              Get.snackbar(
                                'Cart',
                                'Removed from cart',
                                duration: Duration(milliseconds: 800),
                              );
                              setState(() {});
                            },
                            icon: Icon(
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
              ),
            );
        },
      )
          : Center(
        child: Text(
          'Your cart is empty 🛒',
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
