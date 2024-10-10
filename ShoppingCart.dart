import 'Product.dart';

class ShoppingCart {
  List<Product> products = [];
  double totalPrice = 0;

  // Add a product to the shopping cart
  void addProduct(Product product) {
    products.add(product);
    totalPrice += product.price;
  }

  // Calculate and display the total price of products in the cart
  void calculateTotal() {
    print("Products in the cart:\n");
    for (var product in products) {
      print("Product: ${product.name}, Price: ${product.price}");
    }

    print("\nTotal price: $totalPrice");
  }
}
