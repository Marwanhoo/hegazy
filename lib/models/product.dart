import 'package:flutter/material.dart';

/// A selectable color option for a product (swatch + display name).
class ProductColorOption {
  final String name;
  final Color color;

  const ProductColorOption({required this.name, required this.color});
}

/// Static product model used across the app (Model layer).
class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final double? originalPrice; // set only for products on sale
  final String currency;
  final List<String> images;
  final List<ProductColorOption> colors;
  final List<String> sizes;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.originalPrice,
    this.currency = 'EGP',
    required this.images,
    required this.colors,
    required this.sizes,
    required this.category,
  });

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  int get discountPercent => hasDiscount
      ? (((originalPrice! - price) / originalPrice!) * 100).round()
      : 0;

  String get formattedPrice => '${price.toStringAsFixed(0)} $currency';

  String get formattedOriginalPrice =>
      '${originalPrice!.toStringAsFixed(0)} $currency';
}
