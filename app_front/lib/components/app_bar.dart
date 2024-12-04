import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  static const String bannerUrl = 'https://i.ibb.co/MkmKMPT/banner-m.webp';
  static const String logoUrl = 'https://i.ibb.co/H7wKLLZ/logo.webp';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100.0,
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                CustomAppBar.bannerUrl,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.network(
                    CustomAppBar.logoUrl,
                    width: 130,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}