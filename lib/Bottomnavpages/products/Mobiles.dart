import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  bool isclicked = false;
  final storage = GetStorage();
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
  final List<Color> colorOptions = [
    Colors.black,
    Colors.blueGrey,
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Laptop',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 30),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isclicked = !isclicked;
                          Get.snackbar(
                            'Success',
                            isclicked ? 'Added to Cart' : 'Removed from Favourites',
                            duration: Duration(milliseconds: 800),
                          );
                        });
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
              SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                  tag: 'Mobile',
                  child: Image.network(
                    'https://itronics.in/wp-content/uploads/2024/09/iPhone_16_Pro_Natural_Titanium_PDP_Image_Position_1__en-IN.png',
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
                            child: color == Colors.black ? Icon(Icons.check, color: Colors.white) : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Discover the latest smartphone with a high-resolution OLED display, powerful processor, and long-lasting battery life. Experience next-gen performance with seamless multitasking.',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

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
