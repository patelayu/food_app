import 'package:get/get.dart';
import '../model/products.dart';
class ProductController extends GetxController {
  RxList addedProduct = [].obs;
  RxList productQuantity = [].obs;

  void addQuantity({required Product product, required int index}) {
    productQuantity[index]++;
  }

  void removeQuantity({required Product product, required int index}) {
    (productQuantity[index] > 1) ? productQuantity[index]-- : product;
  }

  RxInt get totalQuantity {
    RxInt totalQuantity = 0.obs;
    for (var element in productQuantity) {
      totalQuantity += element;
    }
    return totalQuantity;
    update();
  }

  RxInt get totalPrice {
    RxInt finalTotal = 0.obs;
    for (var element in addedProduct) {
      int index = addedProduct.indexOf(element);
      finalTotal += element.price * productQuantity[index];
    }
    return finalTotal;
    update();
  }

  addProduct({required Product product}) {
    addedProduct.add(product);
    productQuantity.add(1);
    update();
  }

  removeProduct({required Product product, required int quantity}) {
    addedProduct.remove(product);
    productQuantity.remove(quantity);
    update();
  }
}