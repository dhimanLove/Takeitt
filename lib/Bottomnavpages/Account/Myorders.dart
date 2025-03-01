import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});


  List<Map<String, dynamic>> get mockOrders => List.generate(
    10,
        (index) => {
      'orderId': 'ORD-${DateTime.now().subtract(Duration(days: index)).millisecondsSinceEpoch ~/ 1000}',
      'date': DateTime.now().subtract(Duration(days: index)),
      'totalAmount': 50.0 + (index * 15),
      'status': ['Pending', 'Shipped', 'Delivered'][index % 3],
      'items': [_getRandomClothingItem(index)],
    },
  );

  String _getRandomClothingItem(int index) {
    final clothingItems = [
      'Women’s Silk Pajama Set - Navy Blue',
      'Men’s Cotton Pajama Set - Grey',
      'Designer Kurti - Floral Print, Red',
      'Casual Kurti - Solid Black, Cotton',
      'Women’s Nightwear - Pink Satin',
      'Men’s Lounge Wear - Black Track Pants',
      'Ethnic Kurta Set - Maroon, Cotton',
      'Women’s Sleepwear - Lavender, Soft Fabric',
      'Men’s Pyjama Bottoms - Checkered Blue',
      'Traditional Kurti - Embroidered, Green',
    ];
    return clothingItems[index % clothingItems.length];
  }

  Color _getStatusColor(String status) {
    return switch (status) {
      'Pending' => Colors.orange,
      'Shipped' => Colors.blue,
      'Delivered' => Colors.green,
      _ => Colors.grey,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: GoogleFonts.ubuntu(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mockOrders.length,
          itemBuilder: (context, index) {
            final order = mockOrders[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order #${order['orderId'].substring(0, 10)}...',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd').format(order['date']),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Item: ${order['items'].first}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total: \$${order['totalAmount'].toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order['status']),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        order['status'],
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}