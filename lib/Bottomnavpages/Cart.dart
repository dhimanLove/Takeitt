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
    List cartProducts = storage.read('cart_products') ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.4,
              color: Colors.grey[300],
            ),
            cartProducts.isNotEmpty
                ? SizedBox(
                    height: Get.height * 0.5,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          var product = cartProducts[index];
                          return Card(
                            margin: EdgeInsets.all(15),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Text(
                                      'Hot Deal',
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: product['imageUrl']
                                                        ?.startsWith('http') ??
                                                    false
                                                ? Image.network(
                                                    product['imageUrl']!,
                                                    fit: BoxFit.cover,
                                                    height: Get.height * 0.1,
                                                    width: Get.width * 0.2,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    },
                                                  )
                                                : Image.asset(
                                                    product['imageUrl'] ??
                                                        'assets/images/placeholder.png',
                                                    fit: BoxFit.cover,
                                                    height: Get.height * 0.1,
                                                  ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Decrease Button
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (product['quantity'] > 1) {
                                                      product['quantity']--;
                                                    }
                                                  }
                                                  );
                                                },
                                                icon: Icon(Icons.remove,
                                                    color: Colors.red),
                                              ),
                                              // Quantity Text
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black38),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  product['quantity']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              // Increase Button
                                              IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    product['quantity']++;
                                                  });
                                                },
                                                icon: Icon(Icons.add,
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              (product['name'] ?? 'Product Name').toString(),
                                              style: GoogleFonts.inter(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            product['price']?.toString() ??
                                                'Price not available',
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              cartProducts.removeAt(index);
                                              storage.write('cart_products',
                                                  cartProducts);
                                              Get.snackbar(
                                                'Cart',
                                                'Removed from cart',
                                                duration:
                                                    Duration(milliseconds: 800),
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
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                : Center(
                    child: Text(
                      'Your cart is empty 🛒',
                      style: TextStyle(fontSize: 24, color: Colors.grey[900]),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

///Container(
//                 height: Get.height * 0.2,
//                 width: double.infinity,
//                 margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: product['imageUrl']?.startsWith('http') ?? false
//                           ? Image.network(
//                         product['imageUrl']!,
//                         fit: BoxFit.cover,
//                         height: Get.height * 0.1,
//                         width: Get.width * 0.2,
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Center(child: CircularProgressIndicator());
//                         },
//                       )
//                           : Image.asset(
//                         product['imageUrl'] ?? 'assets/images/placeholder.png',
//                         fit: BoxFit.cover,
//                         height: Get.height * 0.1,
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 15),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product['name'] ?? 'Product Name',
//                             style: GoogleFonts.ubuntu(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             product['price']?.toString() ?? 'Price not available',
//                             style: GoogleFonts.ubuntu(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.green[700],
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           IconButton(
//                             onPressed: () {
//                               cartProducts.removeAt(index);
//                               storage.write('cart_products', cartProducts);
//                               Get.snackbar(
//                                 'Cart',
//                                 'Removed from cart',
//                                 duration: Duration(milliseconds: 800),
//                               );
//                               setState(() {});
//                             },
//                             icon: Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                               size: 30,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
