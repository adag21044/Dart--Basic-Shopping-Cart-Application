// main.dart
import 'dart:io';
import 'user.dart'; 
import 'dart:math';
import 'Product.dart';
import 'ShoppingCart.dart';

class MainApp {
  User user;
  ShoppingCart cart;

  MainApp(this.user, this.cart);

  // Kullanıcının yaşına göre indirim uygula
  void applyDiscount() {
    if (user.age != null) {
      if (user.age! < 18) {
        user.totalSpent *= 0.90; // %10 indirim
        print('18 yaş altısınız, %10 indirim uygulandı.');
      } else if (user.age! >= 18 && user.age! <= 60) {
        user.totalSpent *= 0.95; // %5 indirim
        print('18-60 yaş aralığındasınız, %5 indirim uygulandı.');
      } else if (user.age! > 60) {
        user.totalSpent *= 0.85; // %15 indirim
        print('60 yaş üstüsünüz, %15 indirim uygulandı.');
      }
    }
  }

  void displayUserInfo() {
    print('Kullanıcı Yaşı: ${user.age}');
    print('Müşteri Numarası: ${user.customerId}');
    print('Toplam Harcama (İndirimli): ${user.totalSpent.toStringAsFixed(2)} TL');
  }
}

void main() {
  // Kullanıcıdan yaş ve toplam harcama bilgisi alın
  stdout.write('Yaşınızı girin: ');
  String? ageInput = stdin.readLineSync();

  var random = Random();
  int customerId = random.nextInt(100) + 1;

  stdout.write('Toplam harcamanızı girin: ');
  String? totalSpentInput = stdin.readLineSync();

  if (ageInput != null && ageInput.isNotEmpty && totalSpentInput != null && totalSpentInput.isNotEmpty) {
    int age = int.parse(ageInput);
    double totalSpent = double.parse(totalSpentInput);

    // Kullanıcı oluşturma
    User user = User(age: age, customerId: customerId, totalSpent: totalSpent);
    ShoppingCart cart = ShoppingCart();
    MainApp app = MainApp(user, cart);

    // Ürün ekletme döngüsü
    String? continueShopping;
    do {
      stdout.write('Ürün ismi girin: ');
      String? productName = stdin.readLineSync();

      stdout.write('Ürün fiyatını girin: ');
      String? productPriceInput = stdin.readLineSync();

      if (productName != null && productPriceInput != null && productPriceInput.isNotEmpty) {
        double productPrice = double.parse(productPriceInput);
        cart.addProduct(Product(productName, productPrice));
      } else {
        print('Geçersiz giriş.');
      }

      cart.calculateTotal();

      stdout.write('Başka bir ürün eklemek ister misiniz? (e/h): ');
      continueShopping = stdin.readLineSync();
    } while (continueShopping == 'e' || continueShopping == 'E');

    // İndirim uygula ve kullanıcı bilgilerini göster
    app.applyDiscount();
    app.displayUserInfo();
  } else {
    print('Geçersiz giriş.');
  }
}

  

