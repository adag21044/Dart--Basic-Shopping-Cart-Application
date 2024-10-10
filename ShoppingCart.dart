import 'Product.dart';

class ShoppingCart 
{
  List<Product> products = [];
  double totalPrice = 0;

  void addProduct(Product product) 
  {
    products.add(product);
    totalPrice += product.price;
  }

  void calculateTotal()
  {
    print("Products in the cart:\n");
    for (var product in products) 
    {
      print("Product: ${product.name}, Price: ${product.price}");
    }

    print("\nTotal price: $totalPrice");
  }

}