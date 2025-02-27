import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Registercontroller extends GetxController {
  var username = ''.obs;//observable
  var email = ''.obs;
  var profileImage = Rx<File?>(null);

  void setUser(String name, String emaill) {
    username.value = name;
    email.value = emaill;
  }

  void setProfileImage(File image) {
    profileImage.value = image;
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
  // Observable list of cart items, each item is a map containing 'name', 'price', and 'imageUrl'
  var cartItems = <Map<String, dynamic>>[].obs;
  var totalPrice = 0.0.obs;
  var isCartEmpty = true.obs;

  // Load data from storage when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    // Load cart items from GetStorage
    loadCartFromStorage();
  }

  // Load cart items from GetStorage
  void loadCartFromStorage() {
    List<Map<String, dynamic>>? storedCart = GetStorage().read<List<Map<String, dynamic>>>("cart_products");
    if (storedCart != null) {
      cartItems.assignAll(storedCart);
      calculateTotalPrice();
      isCartEmpty.value = cartItems.isEmpty;
    }
  }

  // Add an item to the cart and store it in GetStorage
  void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
    GetStorage().write("cart_products", cartItems);
    calculateTotalPrice();
    isCartEmpty.value = cartItems.isEmpty;
  }

  // Remove an item from the cart and update GetStorage
  void removeFromCart(int index) {
    cartItems.removeAt(index);
    GetStorage().write("cart_products", cartItems);
    calculateTotalPrice();
    isCartEmpty.value = cartItems.isEmpty;
  }

  // Calculate the total price of all cart items
  void calculateTotalPrice() {
    totalPrice.value = cartItems.fold(0.0, (sum, item) => sum + (item['price'] ?? 0.0));
  }
}
