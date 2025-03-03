import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final List<Map<String, dynamic>> coupons = [
    {
      'title': '20% OFF Statewide',
      'code': 'SAVE20',
      'description': 'Valid until March 31, 2025',
      'color': Colors.blue.shade100,
      'icon': Icons.discount,
    },
    {
      'title': 'Free Shipping',
      'code': 'FREE-SHIP',
      'description': 'On orders over \$50',
      'color': Colors.green.shade200,
      'icon': Icons.local_shipping,
    },
    {
      'title': '\$10 OFF',
      'code': 'WELCOME10',
      'description': 'First purchase only',
      'color': Colors.purple.shade200,
      'icon': Icons.card_giftcard,
    },
    {
      'title': '30% OFF Clearance',
      'code': 'CLEAR30',
      'description': 'Limited time offer',
      'color': Colors.red.shade200,
      'icon': Icons.clear_all,
    },
    {
      'title': 'Buy 1 Get 1 Free',
      'code': 'BOG2025',
      'description': 'Select items only',
      'color': Colors.orange.shade200,
      'icon': Icons.add_shopping_cart,
    },
    {
      'title': '15% OFF Everything',
      'code': 'MARCH15',
      'description': 'This month only',
      'color': Colors.teal.shade200,
      'icon': Icons.percent,
    },
    {
      'title': '25% OFF Apparel',
      'code': 'STYLE25',
      'description': 'Valid on clothing items',
      'color': Colors.pink.shade200,
      'icon': Icons.style,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Coupons',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: coupons.map((coupon) {
            return GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: coupon['code']));
                Get.snackbar(
                  'Copied!',
                  'Coupon code ${coupon['code']} copied to clipboard',
                  snackPosition: SnackPosition.TOP,
                  isDismissible: true,
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.black87,
                  dismissDirection: DismissDirection.horizontal,
                  colorText: Colors.white,
                );
              },
              child: Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: Get.height * 0.16,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        coupon['color'],
                        coupon['color'].withOpacity(0.7)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Icon(
                          coupon['icon'],
                          size: 40,
                          color: Colors.grey[800]?.withOpacity(0.8),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coupon['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                coupon['description'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Code: ${coupon['code']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.copy,
                          size: 24,
                          color: Colors.grey[800],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
