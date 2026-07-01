import '../models/product.dart';

/// ViewModel for the product details screen. Plain Dart, no Flutter widget
/// dependency and no `setState` calls — the View wraps calls to its methods
/// in `setState` and reads its fields when rebuilding.
class ProductDetailsViewModel {
  final Product product;

  ProductDetailsViewModel(this.product);

  int galleryIndex = 0;
  int colorIndex = 0;
  int sizeIndex = 0;
  int quantity = 1;

  ProductColorOption get selectedColor => product.colors[colorIndex];
  String get selectedSize => product.sizes[sizeIndex];

  void updateGalleryIndex(int index) {
    galleryIndex = index;
  }

  void selectColor(int index) {
    colorIndex = index;
  }

  void selectSize(int index) {
    sizeIndex = index;
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) quantity--;
  }

  String buildWhatsAppMessage() {
    return 'Hello, I would like to order:\n'
        'Product: ${product.title}\n'
        'Code: ${product.id}\n'
        'Color: ${selectedColor.name}\n'
        'Size: $selectedSize\n'
        'Quantity: $quantity\n'
        'Price: ${product.formattedPrice}';
  }
}
