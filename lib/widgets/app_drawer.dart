import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Drawer showing brand/app details: header, navigation, categories,
/// contact info and social links (static, MVP only).
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
              color: AppColors.primary,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Text(
                      'H',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Hedzy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Elevate Your Everyday Cooking',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _DrawerSectionLabel(label: 'Menu'),
            ListTile(
              leading: const Icon(Icons.home_outlined, color: AppColors.textDark),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Icon(Icons.grid_view_outlined, color: AppColors.textDark),
              title: const Text('All Products'),
              onTap: () => Navigator.of(context).pop(),
            ),
            const Divider(height: 24),
            _DrawerSectionLabel(label: 'Collections'),
            const _CategoryTile(label: 'Pots'),
            const _CategoryTile(label: 'Pans'),
            const _CategoryTile(label: 'Sets'),
            const _CategoryTile(label: 'Dinnerware'),
            const _CategoryTile(label: 'Accessories'),
            const Divider(height: 24),
            _DrawerSectionLabel(label: 'About'),
            const ListTile(
              leading: Icon(Icons.info_outline, color: AppColors.textDark),
              title: Text('About Hedzy'),
              subtitle: Text(
                'Premium cookware designed to elevate everyday cooking.',
              ),
            ),
            const ListTile(
              leading: Icon(Icons.chat_bubble_outline, color: AppColors.textDark),
              title: Text('Contact us on WhatsApp'),
              subtitle: Text('+20 11 12350205'),
            ),
            const Divider(height: 24),
            _DrawerSectionLabel(label: 'Follow us'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  _SocialIcon(icon: Icons.facebook),
                  _SocialIcon(icon: Icons.camera_alt_outlined),
                  _SocialIcon(icon: Icons.music_note_outlined),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Hedzy v1.0.0',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _DrawerSectionLabel extends StatelessWidget {
  final String label;

  const _DrawerSectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String label;

  const _CategoryTile({required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.chevron_right, color: AppColors.textMuted),
      title: Text(label),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;

  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.sage.withValues(alpha: 0.4),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}
