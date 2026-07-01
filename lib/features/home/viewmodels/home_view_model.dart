import '../../../core/data/app_data.dart';
import '../../../core/models/banner_item.dart';
import '../../../core/models/product.dart';

/// ViewModel for the home screen. Plain Dart, no Flutter widget dependency
/// and no `setState` calls — the View wraps calls to its methods in
/// `setState` and reads its fields when rebuilding.
class HomeViewModel {
  final List<Product> products = AppData.products;
  final List<BannerItem> banners = AppData.banners;

  bool isGridView = true;
  int bannerIndex = 0;

  void toggleLayout() {
    isGridView = !isGridView;
  }

  void updateBannerIndex(int index) {
    bannerIndex = index;
  }
}
