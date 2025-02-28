import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Tv extends StatefulWidget {
  const Tv({super.key});

  @override
  State<Tv> createState() => _TvState();
}

class _TvState extends State<Tv> {
  bool productExists = false;
  bool isclicked = false;
  final storage = GetStorage();
  final List<Color> colorOptions = [
    Colors.black,
    Colors.blueGrey,
    Colors.red,
    Colors.blue,
    Colors.green,
  ];
  void addProductToCart(product) {

    List cartProducts = List.from(storage.read('cart_products') ?? []);

    bool productExists = false;
    for (var existingProduct in cartProducts) {
      if (existingProduct['name'] == product['name']) {
        productExists = true;
        break;
      }
    }

    if (productExists) {

      Get.snackbar('Cart', 'Product is already in the cart!', duration: Duration(milliseconds: 800));
    } else {

      cartProducts.add(product);


      storage.write('cart_products', cartProducts);


      Get.snackbar('Cart', 'Product added successfully!', duration: Duration(milliseconds: 800));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Smart TV',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Hero(
                tag: 'Tv',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/462a73798c40c255812e19897c08f9831a88c4f0',
                    fit: BoxFit.cover,
                    height: Get.height * 0.4,
                    width: Get.width,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$1200',
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

              SizedBox(height: 30),
              Text(
                'Experience the best quality Smart TV with 4K resolution, HDR support, and Dolby Atmos sound. Enjoy seamless streaming and gaming with ultra-fast processing.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[900],
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      var product = {
                        'name': 'Samsung LCD',
                        'imageUrl': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/462a73798c40c255812e19897c08f9831a88c4f0',
                        'price': '\$9989',
                      };
                      addProductToCart(product);
                    },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 11),
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
