import 'package:flutter/material.dart';

import '../models/banner_item.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';

/// Static data source (Model layer) for the MVP — no backend/API calls.
class AppData {
  AppData._();

  // Real, free-to-use cookware/kitchenware photos (Unsplash, permanent CDN
  // links, free under the Unsplash License for commercial & non-commercial
  // use, no attribution required).
  static String _img(String id) =>
      '$id?w=900&h=900&fit=crop&crop=entropy&auto=format&q=80';

  static final String _pot1 = _img('https://images.unsplash.com/photo-1556908493-4ac5f138ab77');
  static final String _pot2 = _img('https://images.unsplash.com/photo-1547570917-489da1902994');
  static final String _pot3 = _img('https://images.unsplash.com/photo-1695088224596-11649459b191');

  static final String _pan1 = _img('https://images.unsplash.com/photo-1556940211-ea1d97e04458');
  static final String _pan2 = _img('https://images.unsplash.com/photo-1584990347784-da6aaa2a4bbb');
  static final String _pan3 = _img('https://images.unsplash.com/photo-1695089028153-7ee6393a9981');
  static final String _pan4 = _img('https://images.unsplash.com/photo-1603038124597-2c5c207edf47');
  static final String _pan5 = _img('https://images.unsplash.com/photo-1541508223081-3f8cd5cc0f4c');

  static final String _dinner1 = _img('https://images.unsplash.com/photo-1480889856166-56e89b80386c');
  static final String _dinner2 = _img('https://images.unsplash.com/photo-1629684782790-385ed5adb497');
  static final String _dinner3 = _img('https://images.unsplash.com/photo-1484632105053-8662f3194e7f');
  static final String _dinner4 = _img('https://images.unsplash.com/photo-1522413452208-996ff3f3e740');

  static final String _misc1 = _img('https://images.unsplash.com/photo-1498579992117-24d6ebc00a19');

  static const List<ProductColorOption> _greenBlackCream = [
    ProductColorOption(name: 'Green', color: AppColors.primary),
    ProductColorOption(name: 'Black', color: Color(0xFF23241F)),
    ProductColorOption(name: 'Cream', color: Color(0xFFEFE8DA)),
  ];

  static const List<ProductColorOption> _greenCream = [
    ProductColorOption(name: 'Green', color: AppColors.primary),
    ProductColorOption(name: 'Cream', color: Color(0xFFEFE8DA)),
  ];

  static const List<ProductColorOption> _blackGreen = [
    ProductColorOption(name: 'Black', color: Color(0xFF23241F)),
    ProductColorOption(name: 'Green', color: AppColors.primary),
  ];

  static const List<ProductColorOption> _creamWhite = [
    ProductColorOption(name: 'Cream', color: Color(0xFFEFE8DA)),
    ProductColorOption(name: 'White', color: Color(0xFFFFFFFF)),
  ];

  static const List<ProductColorOption> _blackCream = [
    ProductColorOption(name: 'Black', color: Color(0xFF23241F)),
    ProductColorOption(name: 'Cream', color: Color(0xFFEFE8DA)),
  ];

  static const List<ProductColorOption> _whiteCream = [
    ProductColorOption(name: 'White', color: Color(0xFFFFFFFF)),
    ProductColorOption(name: 'Cream', color: Color(0xFFEFE8DA)),
  ];

  static List<BannerItem> get banners => [
        BannerItem(
          image: _pot1,
          title: 'Elevate Your Everyday Cooking',
          subtitle: 'Discover the new Hegazy collection',
        ),
        BannerItem(
          image: _pan2,
          title: 'Create Your Own Set',
          subtitle: 'Mix and match pots, pans & more',
        ),
        BannerItem(
          image: _dinner1,
          title: 'Experience Better Living',
          subtitle: 'Premium cookware for every kitchen',
        ),
      ];

  static List<Product> get products => [
        Product(
          id: 'HG-001',
          title: 'Hegazy NO.1',
          description:
              'A timeless enamel casserole built for everyday cooking. Even heat '
              'distribution, a tight-fitting lid to lock in moisture, and a '
              'durable finish that goes straight from stovetop to table.',
          price: 1500,
          originalPrice: 1800,
          images: [_pot1, _pot3, _pan5],
          colors: _greenBlackCream,
          sizes: ['20cm', '24cm', '28cm'],
          category: 'Pots',
        ),
        Product(
          id: 'HG-002',
          title: 'Hegazy NO.2',
          description:
              'A versatile non-stick frying pan designed for searing, sautéing '
              'and frying with ease. Comfortable stay-cool handle and a scratch '
              'resistant coating.',
          price: 980,
          images: [_pan1, _pan2, _pan4],
          colors: _blackGreen,
          sizes: ['24cm', '28cm'],
          category: 'Pans',
        ),
        Product(
          id: 'HG-003',
          title: 'Casserole Premium',
          description:
              'Premium cast cookware with a heavy base for consistent heat '
              'retention — perfect for slow-cooked stews and braises.',
          price: 1099,
          originalPrice: 1249,
          images: [_pot2, _pot1],
          colors: _greenCream,
          sizes: ['24cm', '28cm'],
          category: 'Pots',
        ),
        Product(
          id: 'HG-004',
          title: 'Frying Pan LUX Set',
          description:
              'A luxurious frying pan set crafted from forged aluminum with a '
              'triple-layer non-stick coating for effortless cooking and cleanup.',
          price: 1399,
          originalPrice: 1699,
          images: [_pan2, _pan3, _pan4, _pan5],
          colors: _blackGreen,
          sizes: ['24cm', '28cm', '32cm'],
          category: 'Pans',
        ),
        Product(
          id: 'HG-005',
          title: 'ECO Set 9 Pieces',
          description:
              'A complete eco-friendly cookware set covering all your kitchen '
              'essentials — pots, pans and lids made from recycled materials.',
          price: 3699,
          originalPrice: 5500,
          images: [_dinner1, _dinner3, _dinner4],
          colors: _greenCream,
          sizes: ['One Size'],
          category: 'Sets',
        ),
        Product(
          id: 'HG-006',
          title: 'Premium Set 11 Pieces',
          description:
              'Our best-selling premium collection featuring pots, pans and '
              'casseroles finished in a rich enamel coat for a full kitchen upgrade.',
          price: 6199,
          images: [_dinner4, _dinner1, _pot1],
          colors: _greenBlackCream,
          sizes: ['One Size'],
          category: 'Sets',
        ),
        Product(
          id: 'HG-007',
          title: 'Porcelain Casserole',
          description:
              'An elegant porcelain casserole dish that transitions beautifully '
              'from oven to dinner table, oven and dishwasher safe.',
          price: 1150,
          images: [_dinner2, _dinner3],
          colors: _creamWhite,
          sizes: ['20cm', '24cm'],
          category: 'Pots',
        ),
        Product(
          id: 'HG-008',
          title: 'Coffee Pot, 3 Pieces',
          description:
              'A charming stovetop coffee pot set with a stainless steel stand — '
              'brew and serve your favorite blend in style.',
          price: 550,
          images: [_misc1, _dinner2],
          colors: _blackCream,
          sizes: ['Small', 'Medium'],
          category: 'Accessories',
        ),
        Product(
          id: 'HG-009',
          title: 'Double Grill Premium',
          description:
              'A double-sided grill pan for stovetop grilling, delivering '
              'authentic char-grilled flavor to meats and vegetables alike.',
          price: 1699,
          images: [_pan4, _pan1],
          colors: _blackGreen,
          sizes: ['28cm', '32cm'],
          category: 'Pans',
        ),
        Product(
          id: 'HG-010',
          title: 'Tagin Premium',
          description:
              'A traditional conical tagine that slow-cooks meat and vegetables '
              'to tender perfection while sealing in every bit of flavor.',
          price: 1399,
          images: [_pot2, _pot3],
          colors: _greenCream,
          sizes: ['24cm', '28cm'],
          category: 'Pots',
        ),
        Product(
          id: 'HG-011',
          title: 'Bianco Bowl Set',
          description:
              'A minimalist ceramic bowl set in soft neutral tones, ideal for '
              'everyday meals or serving guests in style.',
          price: 1250,
          images: [_dinner2, _dinner3, _dinner1],
          colors: _whiteCream,
          sizes: ['S', 'M', 'L'],
          category: 'Dinnerware',
        ),
        Product(
          id: 'HG-012',
          title: 'Blue Cookware Set 15 Pieces',
          description:
              'A generously sized 15-piece cookware set covering every pot, pan '
              'and utensil you need to fully stock your kitchen.',
          price: 5199,
          images: [_pan5, _pot1, _dinner4],
          colors: _greenBlackCream,
          sizes: ['One Size'],
          category: 'Sets',
        ),
      ];
}
