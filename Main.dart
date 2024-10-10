import 'dart:io';
import 'user.dart';
import 'dart:math';
import 'Product.dart';
import 'ShoppingCart.dart';

class MainApp {
  User user;
  ShoppingCart cart;

  // Constructor to initialize the user and shopping cart
  MainApp(this.user, this.cart);

  // Apply discount based on the user's age
  void applyDiscount() {
    if (user.age != null) {
      if (user.age! < 18) {
        user.totalSpent *= 0.90; // 10% discount
        print('You are under 18, a 10% discount has been applied.');
      } else if (user.age! >= 18 && user.age! <= 60) {
        user.totalSpent *= 0.95; // 5% discount
        print('You are between 18 and 60 years old, a 5% discount has been applied.');
      } else if (user.age! > 60) {
        user.totalSpent *= 0.85; // 15% discount
        print('You are over 60 years old, a 15% discount has been applied.');
      }
    }
  }

  // Display user information
  void displayUserInfo() {
    print('User Age: ${user.age}');
    print('Customer ID: ${user.customerId}');
    print('Total Spending (Discounted): ${user.totalSpent.toStringAsFixed(2)} TL');
  }
}

void main() {
  // Get age and total spending information from the user
  stdout.write('Enter your age: ');
  String? ageInput = stdin.readLineSync();

  var random = Random();
  int customerId = random.nextInt(100) + 1;

  stdout.write('Enter your total spending: ');
  String? totalSpentInput = stdin.readLineSync();

  // Validate user inputs
  if (ageInput != null && ageInput.isNotEmpty && totalSpentInput != null && totalSpentInput.isNotEmpty) {
    int age = int.parse(ageInput);
    double totalSpent = double.parse(totalSpentInput);

    // Create a User instance
    User user = User(age: age, customerId: customerId, totalSpent: totalSpent);
    ShoppingCart cart = ShoppingCart();
    MainApp app = MainApp(user, cart);

    // Product addition loop
    String? continueShopping;
    do {
      stdout.write('Enter product name: ');
      String? productName = stdin.readLineSync();

      stdout.write('Enter product price: ');
      String? productPriceInput = stdin.readLineSync();

      // Validate product inputs
      if (productName != null && productPriceInput != null && productPriceInput.isNotEmpty) {
        double productPrice = double.parse(productPriceInput);
        cart.addProduct(Product(productName, productPrice));
      } else {
        print('Invalid input.');
      }

      cart.calculateTotal();

      // Ask if the user wants to continue shopping
      stdout.write('Would you like to add another product? (y/n): ');
      continueShopping = stdin.readLineSync();
    } while (continueShopping == 'y' || continueShopping == 'Y');

    // Apply discount and display user information
    app.applyDiscount();
    app.displayUserInfo();
  } else {
    print('Invalid input.');
  }
}
