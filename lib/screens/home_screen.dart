import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_colors.dart';
import '../viewmodels/home_view_model.dart';
import '../widgets/app_drawer.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/product_card.dart';
import 'product_details_screen.dart';

/// Home screen (View layer): banner carousel, grid/list product toggle and
/// the product listing. Owns a [HomeViewModel] and drives rebuilds via
/// `setState`.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel();

  void _openProduct(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Hegazy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BannerCarousel(
              banners: _viewModel.banners,
              onPageChanged: (index) {
                setState(() => _viewModel.updateBannerIndex(index));
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Best Sellers',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.divider),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _LayoutToggleButton(
                          icon: Icons.grid_view_rounded,
                          isSelected: _viewModel.isGridView,
                          onTap: () {
                            if (!_viewModel.isGridView) {
                              setState(() => _viewModel.toggleLayout());
                            }
                          },
                        ),
                        _LayoutToggleButton(
                          icon: Icons.view_list_rounded,
                          isSelected: !_viewModel.isGridView,
                          onTap: () {
                            if (_viewModel.isGridView) {
                              setState(() => _viewModel.toggleLayout());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_viewModel.isGridView)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.66,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = _viewModel.products[index];
                    return ProductGridCard(
                      product: product,
                      onTap: () => _openProduct(product),
                    );
                  },
                  childCount: _viewModel.products.length,
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = _viewModel.products[index];
                    return ProductListCard(
                      product: product,
                      onTap: () => _openProduct(product),
                    );
                  },
                  childCount: _viewModel.products.length,
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _LayoutToggleButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _LayoutToggleButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        margin: const EdgeInsets.all(3),
        child: Icon(
          icon,
          size: 18,
          color: isSelected ? Colors.white : AppColors.textMuted,
        ),
      ),
    );
  }
}
