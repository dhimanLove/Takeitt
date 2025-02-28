import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Registercontroller extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var profileImageUrl = ''.obs; // Changed from Rx<File?> to RxString for Supabase URL

  void setUser(String name, String emaill, [String? imageUrl]) {
    username.value = name;
    email.value = emaill;
    if (imageUrl != null) {
      profileImageUrl.value = imageUrl;
    }
  }


  void setProfileImage(File image) {
  }
}

class Logincontroler extends GetxController {
  var email = ''.obs;

  void setUser(String mail) {
    email.value = mail;
  }
}

class CategoryController extends GetxController {
  var selectedCategory = "Shoes".obs;

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}

class FilterController extends GetxController {
  var selectedFilter = 'Shoes'.obs;
  List<String> filters = [
    'Shoes', 'Laptops', 'Electronics', 'Food', 'Kitchen', 'Furniture', 'Mobile', 'Kids'
  ];

  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }
}

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;
  var totalPrice = 0.0.obs;
  var isCartEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
  }

  void loadCartFromStorage() {
    List<dynamic>? storedCart = GetStorage().read<List<dynamic>>("cart_products");
    if (storedCart != null) {
      cartItems.assignAll(storedCart.map((e) => Map<String, dynamic>.from(e)));
      calculateTotalPrice();
      isCartEmpty.value = cartItems.isEmpty;
    }
  }

  void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
    GetStorage().write("cart_products", cartItems);
    calculateTotalPrice();
    isCartEmpty.value = cartItems.isEmpty;
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    GetStorage().write("cart_products", cartItems);
    calculateTotalPrice();
    isCartEmpty.value = cartItems.isEmpty;
  }

  void calculateTotalPrice() {
    totalPrice.value = cartItems.fold(
      0.0,
          (sum, item) {
        // Handle price as a string with currency symbol if needed
        String priceStr = item['price']?.toString().replaceAll(RegExp(r'[^\d]'), '') ?? '0';
        double price = double.tryParse(priceStr) ?? 0.0;
        return sum + price;
      },
    );
  }
}