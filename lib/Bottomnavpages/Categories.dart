import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:takeittt/components/chips.dart';
import 'package:takeittt/components/searchdelegate.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String selectedCategory = "Shoes";

  final List<Map<String, String>> categories = [
    {
      'name': 'Shoes',
      'image':
          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/5bbfe23c77dba13d3d66f5ac89c635e57a9e1760'
    },
    {
      'name': 'Laptops',
      'image':
          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/e657c53932a88a3ce64a69c3aa4020ab905cba80'
    },
    {
      'name': 'Electronics',
      'image':
          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/36f1b34ead89d698c8398df35328dc3199832dd2'
    },
    {
      'name': 'Food',
      'image':
          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/b110c9706899f0576925cedc9071d0878df9a02b'
    },
    {
      'name': 'Kitchen',
      'image':
          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/38cd63967850764e01de4a5aa9d4143bf74c51a3'
    },
    {
      'name': 'Furniture',
      'image':
          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/59521a05d27744ff70c2527585f373799b2911b1'
    },
    {
      'name': 'Mobile',
      'image':
          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/756410b241e1b9b45d7fde0815c9d0c9e245a86b'
    },
    {
      'name': 'Kids',
      'image':
          'https://www.figma.com/file/4fsrPVHqwtxNSPbVMPcchJ/image/6393197f4aab7aa0fcf943f6d34b903fed3a168e'
    },
  ];

  final Map<String, List<Map<String, String>>> items = {
    "Shoes": [
      {
        "name": "Gucci Ace",
        "image":
            "https://images.unsplash.com/photo-1608231387042-66d1773070a5?q=80&w=687&auto=format&fit=crop",
        "price": "2000"
      },
      {
        "name": "Adidas Boost",
        "image":
            "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=687&auto=format&fit=crop",
        "price": "1800"
      },
      {
        "name": "Nike Air",
        "image":
            "https://images.unsplash.com/photo-1542296337-4d377e06d1d6?q=80&w=687&auto=format&fit=crop",
        "price": "1900"
      },
      {
        "name": "Puma Runner",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "1700"
      },
      {
        "name": "Reebok Classic",
        "image":
            "https://images.unsplash.com/photo-1595950659212-1a9f6d7c88b7?q=80&w=687&auto=format&fit=crop",
        "price": "1600"
      },
      {
        "name": "Converse Chuck",
        "image":
            "https://images.unsplash.com/photo-1491553895911-0055eca6402d?q=80&w=687&auto=format&fit=crop",
        "price": "1500"
      },
      {
        "name": "Vans Old Skool",
        "image":
            "https://images.unsplash.com/photo-1525966222134-fbfa99b8ae77?q=80&w=687&auto=format&fit=crop",
        "price": "1400"
      },
      {
        "name": "New Balance 990",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "1300"
      },
      {
        "name": "Timberland Boots",
        "image":
            "https://images.unsplash.com/photo-1542779283-429940ce8336?q=80&w=687&auto=format&fit=crop",
        "price": "1200"
      },
      {
        "name": "Skechers Go Walk",
        "image":
            "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?q=80&w=687&auto=format&fit=crop",
        "price": "1100"
      },
    ],
    "Laptops": [
      {
        "name": "MacBook Pro",
        "image":
            "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=687&auto=format&fit=crop",
        "price": "2500"
      },
      {
        "name": "Dell XPS",
        "image":
            "https://images.unsplash.com/photo-1573743345860-21662d8e82c0?q=80&w=687&auto=format&fit=crop",
        "price": "2200"
      },
      {
        "name": "HP Spectre",
        "image":
            "https://images.unsplash.com/photo-1593642634367-d91a5a4f8e42?q=80&w=687&auto=format&fit=crop",
        "price": "2100"
      },
      {
        "name": "Lenovo ThinkPad",
        "image":
            "https://images.unsplash.com/photo-1588702547923-2a33eecd7526?q=80&w=687&auto=format&fit=crop",
        "price": "2000"
      },
      {
        "name": "Asus ZenBook",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "1900"
      },
      {
        "name": "Microsoft Surface",
        "image":
            "https://images.unsplash.com/photo-1611078489935-0cb964de309d?q=80&w=687&auto=format&fit=crop",
        "price": "1800"
      },
      {
        "name": "Acer Predator",
        "image":
            "https://images.unsplash.com/photo-1593642632823-8f785ba67e45?q=80&w=687&auto=format&fit=crop",
        "price": "1700"
      },
      {
        "name": "Razer Blade",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "1600"
      },
      {
        "name": "Samsung Galaxy Book",
        "image":
            "https://images.unsplash.com/photo-1611078489935-0cb964de309d?q=80&w=687&auto=format&fit=crop",
        "price": "1500"
      },
      {
        "name": "LG Gram",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "1400"
      },
    ],
    "Electronics": [
      {
        "name": "iPhone 12",
        "image":
            "https://images.unsplash.com/photo-1605787020600-81255e90d06b?q=80&w=687&auto=format&fit=crop",
        "price": "1200"
      },
      {
        "name": "Samsung Galaxy S21",
        "image":
            "https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?q=80&w=687&auto=format&fit=crop",
        "price": "1100"
      },
      {
        "name": "Sony Headphones",
        "image":
            "https://images.unsplash.com/photo-1505751172876-fa1923c5c7a8?q=80&w=687&auto=format&fit=crop",
        "price": "300"
      },
      {
        "name": "Apple Watch",
        "image":
            "https://images.unsplash.com/photo-1559056199-6d4d075a5d62?q=80&w=687&auto=format&fit=crop",
        "price": "400"
      },
      {
        "name": "Amazon Echo",
        "image":
            "https://images.unsplash.com/photo-1518444065439-e933c1ce31d8?q=80&w=687&auto=format&fit=crop",
        "price": "100"
      },
      {
        "name": "Google Pixel 5",
        "image":
            "https://images.unsplash.com/photo-1601134467661-3d775b999c8b?q=80&w=687&auto=format&fit=crop",
        "price": "900"
      },
      {
        "name": "Bose Speaker",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "200"
      },
      {
        "name": "Nintendo Switch",
        "image":
            "https://images.unsplash.com/photo-1578301978068-96604df1a1ec?q=80&w=687&auto=format&fit=crop",
        "price": "300"
      },
      {
        "name": "Fitbit Charge",
        "image":
            "https://images.unsplash.com/photo-1575318633968-0c363387b5e1?q=80&w=687&auto=format&fit=crop",
        "price": "150"
      },
      {
        "name": "Canon DSLR",
        "image":
            "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=687&auto=format&fit=crop",
        "price": "800"
      },
    ],
    "Food": [
      {
        "name": "Pizza",
        "image":
            "https://images.unsplash.com/photo-1513106580091-1d82408b8b62?q=80&w=687&auto=format&fit=crop",
        "price": "15"
      },
      {
        "name": "Burger",
        "image":
            "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=687&auto=format&fit=crop",
        "price": "10"
      },
      {
        "name": "Sushi",
        "image":
            "https://images.unsplash.com/photo-1553621042-f6e147245754?q=80&w=687&auto=format&fit=crop",
        "price": "20"
      },
      {
        "name": "Pasta",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "12"
      },
      {
        "name": "Salad",
        "image":
            "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=687&auto=format&fit=crop",
        "price": "8"
      },
      {
        "name": "Tacos",
        "image":
            "https://images.unsplash.com/photo-1551504734-5ee1c4a14705?q=80&w=687&auto=format&fit=crop",
        "price": "9"
      },
      {
        "name": "Steak",
        "image":
            "https://images.unsplash.com/photo-1600891964599-f61ba0e24092?q=80&w=687&auto=format&fit=crop",
        "price": "25"
      },
      {
        "name": "Sandwich",
        "image":
            "https://images.unsplash.com/photo-1552611052-33e04b2c0c43?q=80&w=687&auto=format&fit=crop",
        "price": "7"
      },
      {
        "name": "Cake",
        "image":
            "https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=687&auto=format&fit=crop",
        "price": "18"
      },
      {
        "name": "Ice Cream",
        "image":
            "https://images.unsplash.com/photo-1497034825431-c343309a68b9?q=80&w=687&auto=format&fit=crop",
        "price": "5"
      },
    ],
    "Kitchen": [
      {
        "name": "Blender",
        "image":
            "https://images.unsplash.com/photo-1587135945135-2c98b741ace8?q=80&w=687&auto=format&fit=crop",
        "price": "100"
      },
      {
        "name": "Toaster",
        "image":
            "https://images.unsplash.com/photo-1587735246890-5a614570a09e?q=80&w=687&auto=format&fit=crop",
        "price": "50"
      },
      {
        "name": "Microwave",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "150"
      },
      {
        "name": "Coffee Maker",
        "image":
            "https://images.unsplash.com/photo-1587735246890-5a614570a09e?q=80&w=687&auto=format&fit=crop",
        "price": "80"
      },
      {
        "name": "Air Fryer",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "120"
      },
      {
        "name": "Slow Cooker",
        "image":
            "https://images.unsplash.com/photo-1587135945135-2c98b741ace8?q=80&w=687&auto=format&fit=crop",
        "price": "90"
      },
      {
        "name": "Food Processor",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "70"
      },
      {
        "name": "Electric Kettle",
        "image":
            "https://images.unsplash.com/photo-1587735246890-5a614570a09e?q=80&w=687&auto=format&fit=crop",
        "price": "40"
      },
      {
        "name": "Rice Cooker",
        "image":
            "https://images.unsplash.com/photo-1587135945135-2c98b741ace8?q=80&w=687&auto=format&fit=crop",
        "price": "60"
      },
      {
        "name": "Pressure Cooker",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "110"
      },
    ],
    "Furniture": [
      {
        "name": "Sofa",
        "image":
            "https://images.unsplash.com/photo-1550583724-3b5c452122a2?q=80&w=687&auto=format&fit=crop",
        "price": "500"
      },
      {
        "name": "Dining Table",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "400"
      },
      {
        "name": "Chair",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "100"
      },
      {
        "name": "Bed",
        "image":
            "https://images.unsplash.com/photo-1505691938895-63b8c5b73ddb?q=80&w=687&auto=format&fit=crop",
        "price": "600"
      },
      {
        "name": "Coffee Table",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "200"
      },
      {
        "name": "Bookshelf",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "300"
      },
      {
        "name": "Wardrobe",
        "image":
            "https://images.unsplash.com/photo-1550583724-3b5c452122a2?q=80&w=687&auto=format&fit=crop",
        "price": "700"
      },
      {
        "name": "Desk",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "250"
      },
      {
        "name": "Armchair",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "350"
      },
      {
        "name": "Cabinet",
        "image":
            "https://images.unsplash.com/photo-1550583724-3b5c452122a2?q=80&w=687&auto=format&fit=crop",
        "price": "450"
      },
    ],
    "Mobile": [
      {
        "name": "Samsung S21",
        "image":
            "https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?q=80&w=687&auto=format&fit=crop",
        "price": "1000"
      },
      {
        "name": "OnePlus 9",
        "image":
            "https://images.unsplash.com/photo-1612297235488-8513a7f09a5e?q=80&w=687&auto=format&fit=crop",
        "price": "900"
      },
      {
        "name": "Google Pixel 5",
        "image":
            "https://images.unsplash.com/photo-1601134467661-3d775b999c8b?q=80&w=687&auto=format&fit=crop",
        "price": "800"
      },
      {
        "name": "Xiaomi Mi 11",
        "image":
            "https://images.unsplash.com/photo-1605787020600-81255e90d06b?q=80&w=687&auto=format&fit=crop",
        "price": "700"
      },
      {
        "name": "Huawei P40",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "850"
      },
      {
        "name": "Oppo Find X3",
        "image":
            "https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?q=80&w=687&auto=format&fit=crop",
        "price": "950"
      },
      {
        "name": "Vivo X60",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "750"
      },
      {
        "name": "Realme GT",
        "image":
            "https://images.unsplash.com/photo-1612297235488-8513a7f09a5e?q=80&w=687&auto=format&fit=crop",
        "price": "650"
      },
      {
        "name": "Motorola Edge",
        "image":
            "https://images.unsplash.com/photo-1601134467661-3d775b999c8b?q=80&w=687&auto=format&fit=crop",
        "price": "600"
      },
      {
        "name": "Nokia 8.3",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "550"
      },
    ],
    "Kids": [
      {
        "name": "Toy Car",
        "image":
            "https://images.unsplash.com/photo-1587654780291-39c9404d746b?q=80&w=687&auto=format&fit=crop",
        "price": "20"
      },
      {
        "name": "Doll",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "15"
      },
      {
        "name": "Board Game",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "25"
      },
      {
        "name": "Puzzle",
        "image":
            "https://images.unsplash.com/photo-1587654780291-39c9404d746b?q=80&w=687&auto=format&fit=crop",
        "price": "10"
      },
      {
        "name": "Stuffed Animal",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "18"
      },
      {
        "name": "Action Figure",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "22"
      },
      {
        "name": "Building Blocks",
        "image":
            "https://images.unsplash.com/photo-1587654780291-39c9404d746b?q=80&w=687&auto=format&fit=crop",
        "price": "30"
      },
      {
        "name": "Play Dough",
        "image":
            "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=687&auto=format&fit=crop",
        "price": "8"
      },
      {
        "name": "Remote Control Car",
        "image":
            "https://images.unsplash.com/photo-1600585154526-990dced4db0d?q=80&w=687&auto=format&fit=crop",
        "price": "40"
      },
      {
        "name": "Coloring Book",
        "image":
            "https://images.unsplash.com/photo-1587654780291-39c9404d746b?q=80&w=687&auto=format&fit=crop",
        "price": "7"
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu, color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        title: Text('Categories',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: MySearchDelegate()),
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.mic, color: Colors.white)),
          IconButton(
              onPressed: () => Get.toNamed('/cart'),
              icon: Icon(Icons.shopping_cart, color: Colors.white)),
        ],
        elevation: 0,
      ),
      body: Column(children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(children: [
                Icon(Icons.shopping_bag, color: Colors.orange, size: 24),
                Text('For You',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ]),
            ),
            FilterChipsScreen(),
          ]),
        ),
        Expanded(
            child: Row(children: [
          Container(
            width: Get.width * 0.2,
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index]['name']!;
                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = category),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                        color: selectedCategory == category
                            ? Colors.blueAccent
                            : Colors.transparent,
                        width: 3,
                      )),
                    ),
                    child: Column(children: [
                      CachedNetworkImage(
                        imageUrl: categories[index]['image']!,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(color: Colors.grey),
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, size: 40),
                      ),
                      SizedBox(height: 4),
                      Text(
                        category,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: selectedCategory == category
                              ? Colors.blueAccent
                              : Colors.black,
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemCount: items[selectedCategory]?.length ?? 0,
            itemBuilder: (context, index) {
              final item = items[selectedCategory]![index];
              return Column(children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: item['image']!,
                        width: Get.width * 0.25,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(color: Colors.grey),
                        ),
                        errorWidget: (context, url, error) =>
                            Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: Get.width * 0.25,
                            height: Get.width * 0.25,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 4),
                Text(
                  item['name']!,
                  style: GoogleFonts.poppins(
                      fontSize: 10, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ]);
            },
          )),
        ])),
      ]),
    );
  }
}
