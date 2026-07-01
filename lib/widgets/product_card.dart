import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/app_colors.dart';

/// A product thumbnail image shared by both card variants, with graceful
/// loading/error states for the network images.
class _ProductImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const _ProductImage({
    required this.url,
    required this.borderRadius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            width: width,
            height: height,
            color: AppColors.sage.withValues(alpha: 0.25),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          color: AppColors.sage.withValues(alpha: 0.25),
          child: const Icon(Icons.image_not_supported_outlined),
        ),
      ),
    );
  }
}

/// A small "Sale" pill shown over the thumbnail of discounted products.
class SaleBadge extends StatelessWidget {
  const SaleBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'Sale',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// Price display shared across product cards and the details screen: shows
/// a plain price, or — when [Product.hasDiscount] — the strikethrough
/// original price, the sale price and a "-NN%" chip.
class PriceRow extends StatelessWidget {
  final Product product;
  final double priceFontSize;
  final double originalFontSize;

  const PriceRow({
    super.key,
    required this.product,
    this.priceFontSize = 13,
    this.originalFontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (!product.hasDiscount) {
      return Text(
        product.formattedPrice,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: priceFontSize,
          color: AppColors.primary,
        ),
      );
    }
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      runSpacing: 2,
      children: [
        Text(
          product.formattedOriginalPrice,
          style: TextStyle(
            fontSize: originalFontSize,
            color: AppColors.textMuted,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        Text(
          product.formattedPrice,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: priceFontSize,
            color: AppColors.primary,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '-${product.discountPercent}%',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

/// Grid-mode product card: image on top, title/price below.
class ProductGridCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductGridCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  _ProductImage(
                    url: product.images.first,
                    borderRadius: BorderRadius.zero,
                  ),
                  if (product.hasDiscount)
                    const Positioned(top: 8, left: 8, child: SaleBadge()),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  PriceRow(product: product),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// List-mode product card: thumbnail on the left, details on the right.
class ProductListCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductListCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 84,
              height: 84,
              child: Stack(
                children: [
                  _ProductImage(
                    url: product.images.first,
                    width: 84,
                    height: 84,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  if (product.hasDiscount)
                    const Positioned(top: 4, left: 4, child: SaleBadge()),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  PriceRow(product: product),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
