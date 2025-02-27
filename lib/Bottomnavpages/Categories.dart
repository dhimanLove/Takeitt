import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takeittt/components/chips.dart';
import 'package:takeittt/components/mydrawer.dart';
import 'package:takeittt/components/searchdelegate.dart';
import 'package:takeittt/routes/routenames.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}
class _CategoriesState extends State<Categories> {
  String selectedCategory = "Shoes";

  final List<Map<String, String>> categories = [
    {'name': 'Shoes', 'image': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/5bbfe23c77dba13d3d66f5ac89c635e57a9e1760'},
    {'name': 'Laptops', 'image': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/e657c53932a88a3ce64a69c3aa4020ab905cba80'},
    {'name': 'Electronics', 'image': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/36f1b34ead89d698c8398df35328dc3199832dd2'},
    {'name': 'Food', 'image': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/b110c9706899f0576925cedc9071d0878df9a02b'},
    {'name': 'Kitchen', 'image': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/38cd63967850764e01de4a5aa9d4143bf74c51a3'},
    {'name': 'Furniture', 'image': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/59521a05d27744ff70c2527585f373799b2911b1'},
    {'name': 'Mobile', 'image': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/756410b241e1b9b45d7fde0815c9d0c9e245a86b'},
    {'name': 'Kids', 'image': 'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/6393197f4aab7aa0fcf943f6d34b903fed3a168e'},
  ];

  final Map<String, List<Map<String, String>>> items = {
    "Shoes": [
      {
        "name": "Gucci Ace",
        "image": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=687&auto=format&fit=crop",
        "price": "2000"
      },
      {
        "name": "Adidas Boost",
        "image": "https://images.unsplash.com/photo-1543163521-1bf5498e65ba?q=80&w=687&auto=format&fit=crop",
        "price": "1800"
      },
      {
        "name": "Nike Air",
        "image": "https://images.unsplash.com/photo-1544472260-7628f5a7f18c?q=80&w=687&auto=format&fit=crop",
        "price": "1900"
      },
      {
        "name": "Puma Runner",
        "image": "https://images.unsplash.com/photo-1580292321394-deef66d5d963?q=80&w=687&auto=format&fit=crop",
        "price": "1700"
      },
      {
        "name": "Reebok Classic",
        "image": "https://images.unsplash.com/photo-1595950659212-178a9f2883f7?q=80&w=687&auto=format&fit=crop",
        "price": "1600"
      },
      {
        "name": "Converse Chuck",
        "image": "https://images.unsplash.com/photo-1543163521-1bf5498e65ba?q=80&w=687&auto=format&fit=crop",
        "price": "1500"
      },
      {
        "name": "Vans Old Skool",
        "image": "https://images.unsplash.com/photo-1544472260-7628f5a7f18c?q=80&w=687&auto=format&fit=crop",
        "price": "1400"
      },
      {
        "name": "New Balance 990",
        "image": "https://images.unsplash.com/photo-1580292321394-deef66d5d963?q=80&w=687&auto=format&fit=crop",
        "price": "1300"
      },
      {
        "name": "Timberland Boots",
        "image": "https://images.unsplash.com/photo-1595950659212-178a9f2883f7?q=80&w=687&auto=format&fit=crop",
        "price": "1200"
      },
      {
        "name": "Skechers Go Walk",
        "image": "https://images.unsplash.com/photo-1543163521-1bf5498e65ba?q=80&w=687&auto=format&fit=crop",
        "price": "1100"
      },
    ],
    "Laptops": [
      {
        "name": "MacBook Pro",
        "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=687&auto=format&fit=crop",
        "price": "2500"
      },
      {
        "name": "Dell XPS",
        "image": "https://images.unsplash.com/photo-1517430816045-df4b7de11d1b?q=80&w=687&auto=format&fit=crop",
        "price": "2200"
      },
      {
        "name": "HP Spectre",
        "image": "https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=687&auto=format&fit=crop",
        "price": "2100"
      },
      {
        "name": "Lenovo ThinkPad",
        "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=687&auto=format&fit=crop",
        "price": "2000"
      },
      {
        "name": "Asus ZenBook",
        "image": "https://images.unsplash.com/photo-1517430816045-df4b7de11d1b?q=80&w=687&auto=format&fit=crop",
        "price": "1900"
      },
      {
        "name": "Microsoft Surface",
        "image": "https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=687&auto=format&fit=crop",
        "price": "1800"
      },
      {
        "name": "Acer Predator",
        "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=687&auto=format&fit=crop",
        "price": "1700"
      },
      {
        "name": "Razer Blade",
        "image": "https://images.unsplash.com/photo-1517430816045-df4b7de11d1b?q=80&w=687&auto=format&fit=crop",
        "price": "1600"
      },
      {
        "name": "Samsung Galaxy Book",
        "image": "https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=687&auto=format&fit=crop",
        "price": "1500"
      },
      {
        "name": "LG Gram",
        "image": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=687&auto=format&fit=crop",
        "price": "1400"
      },
    ],
    "Electronics": [
      {
        "name": "iPhone 12",
        "image": "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=687&auto=format&fit=crop",
        "price": "1200"
      },
      {
        "name": "Samsung Galaxy S21",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "1100"
      },
      {
        "name": "Sony Headphones",
        "image": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=687&auto=format&fit=crop",
        "price": "300"
      },
      {
        "name": "Apple Watch",
        "image": "https://images.unsplash.com/photo-1543963197-bdccb1abf33f?q=80&w=687&auto=format&fit=crop",
        "price": "400"
      },
      {
        "name": "Amazon Echo",
        "image": "https://images.unsplash.com/photo-1563986768609-3146d51b63a0?q=80&w=687&auto=format&fit=crop",
        "price": "100"
      },
      {
        "name": "Google Pixel 5",
        "image": "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=687&auto=format&fit=crop",
        "price": "900"
      },
      {
        "name": "Bose Speaker",
        "image": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=687&auto=format&fit=crop",
        "price": "200"
      },
      {
        "name": "Nintendo Switch",
        "image": "https://images.unsplash.com/photo-1543963197-bdccb1abf33f?q=80&w=687&auto=format&fit=crop",
        "price": "300"
      },
      {
        "name": "Fitbit Charge",
        "image": "https://images.unsplash.com/photo-1563986768609-3146d51b63a0?q=80&w=687&auto=format&fit=crop",
        "price": "150"
      },
      {
        "name": "Canon DSLR",
        "image": "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=687&auto=format&fit=crop",
        "price": "800"
      },
    ],
    "Food": [
      {
        "name": "Pizza",
        "image": "https://images.unsplash.com/photo-1565299624946-b29baf4b2f27?q=80&w=687&auto=format&fit=crop",
        "price": "15"
      },
      {
        "name": "Burger",
        "image": "https://images.unsplash.com/photo-1552982306-bf96b0a1f8f0?q=80&w=687&auto=format&fit=crop",
        "price": "10"
      },
      {
        "name": "Sushi",
        "image": "https://images.unsplash.com/photo-1516982557981-2f7e937d31c1?q=80&w=687&auto=format&fit=crop",
        "price": "20"
      },
      {
        "name": "Pasta",
        "image": "https://images.unsplash.com/photo-1565299624946-b29baf4b2f27?q=80&w=687&auto=format&fit=crop",
        "price": "12"
      },
      {
        "name": "Salad",
        "image": "https://images.unsplash.com/photo-1546793665-c74683f2b13c?q=80&w=687&auto=format&fit=crop",
        "price": "8"
      },
      {
        "name": "Tacos",
        "image": "https://images.unsplash.com/photo-1552982306-bf96b0a1f8f0?q=80&w=687&auto=format&fit=crop",
        "price": "9"
      },
      {
        "name": "Steak",
        "image": "https://images.unsplash.com/photo-1516982557981-2f7e937d31c1?q=80&w=687&auto=format&fit=crop",
        "price": "25"
      },
      {
        "name": "Sandwich",
        "image": "https://images.unsplash.com/photo-1565299624946-b29baf4b2f27?q=80&w=687&auto=format&fit=crop",
        "price": "7"
      },
      {
        "name": "Cake",
        "image": "https://images.unsplash.com/photo-1546793665-c74683f2b13c?q=80&w=687&auto=format&fit=crop",
        "price": "18"
      },
      {
        "name": "Ice Cream",
        "image": "https://images.unsplash.com/photo-1552982306-bf96b0a1f8f0?q=80&w=687&auto=format&fit=crop",
        "price": "5"
      },
    ],
    "Kitchen": [
      {
        "name": "Blender",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "100"
      },
      {
        "name": "Toaster",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "50"
      },
      {
        "name": "Microwave",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "150"
      },
      {
        "name": "Coffee Maker",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "80"
      },
      {
        "name": "Air Fryer",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "120"
      },
      {
        "name": "Slow Cooker",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "90"
      },
      {
        "name": "Food Processor",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "70"
      },
      {
        "name": "Electric Kettle",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "40"
      },
      {
        "name": "Rice Cooker",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "60"
      },
      {
        "name": "Pressure Cooker",
        "image": "https://images.unsplash.com/photo-1583343763852-cd958015a800?q=80&w=687&auto=format&fit=crop",
        "price": "110"
      },
    ],
    "Furniture": [
      {
        "name": "Sofa",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "500"
      },
      {
        "name": "Dining Table",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "400"
      },
      {
        "name": "Chair",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "100"
      },
      {
        "name": "Bed",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "600"
      },
      {
        "name": "Coffee Table",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "200"
      },
      {
        "name": "Bookshelf",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "300"
      },
      {
        "name": "Wardrobe",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "700"
      },
      {
        "name": "Desk",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "250"
      },
      {
        "name": "Armchair",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "350"
      },
      {
        "name": "Cabinet",
        "image": "https://images.unsplash.com/photo-1556911135-3ffa999a1757?q=80&w=687&auto=format&fit=crop",
        "price": "450"
      },
    ],
    "Mobile": [
      {
        "name": "Samsung S21",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "1000"
      },
      {
        "name": "OnePlus 9",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "900"
      },
      {
        "name": "Google Pixel 5",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "800"
      },
      {
        "name": "Xiaomi Mi 11",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "700"
      },
      {
        "name": "Huawei P40",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "850"
      },
      {
        "name": "Oppo Find X3",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "950"
      },
      {
        "name": "Vivo X60",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "750"
      },
      {
        "name": "Realme GT",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "650"
      },
      {
        "name": "Motorola Edge",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "600"
      },
      {
        "name": "Nokia 8.3",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "550"
      },
    ],
    "Kids": [
      {
        "name": "Toy Car",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "20"
      },
      {
        "name": "Doll",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "15"
      },
      {
        "name": "Board Game",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "25"
      },
      {
        "name": "Puzzle",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "10"
      },
      {
        "name": "Stuffed Animal",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "18"
      },
      {
        "name": "Action Figure",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "22"
      },
      {
        "name": "Building Blocks",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "30"
      },
      {
        "name": "Play Dough",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "8"
      },
      {
        "name": "Remote Control Car",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "40"
      },
      {
        "name": "Coloring Book",
        "image": "https://images.unsplash.com/photo-1512499617640-c2f999018b72?q=80&w=687&auto=format&fit=crop",
        "price": "7"
      },
    ],
  };

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
                 onPressed: () {
                     Scaffold.of(context).openDrawer();
                   },
                   icon: const Icon(Icons.menu, color: Colors.white),
                 ),
        backgroundColor: Colors.blueAccent,
        title: const Text('All Categories', style: TextStyle(fontSize: 20, color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: MySearchDelegate()),
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic, color: Colors.white),
          ),
          IconButton(
            onPressed: () => Get.toNamed(Routenames.cart),
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),

      body:
      Column(
        children: [
          // Title Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(Icons.shopping_bag, color: Colors.orange, size: 30),
                      const SizedBox(height: 5),
                      const Text(
                        'For You',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                FilterChipsScreen(),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  width: Get.width * 0.2,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index]['name']!;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: selectedCategory == category ? Colors.blueAccent : Colors.grey[200]!,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                height: 50,
                                width: 50,
                                categories[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                category,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: selectedCategory == category ? Colors.blueAccent : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                // GridView for Items
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 30,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: items[selectedCategory]?.length,
                      itemBuilder: (context, index) {
                        final item = items[selectedCategory]?[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.network(
                                  item?['image'] ?? "",
                                  width: Get.width * 0.21,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported, size: 50),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item?['name'] ?? "No Name",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
