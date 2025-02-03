import 'package:flutter/material.dart';

import 'package:lh_imoveis/repository/base_repositorio.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
  
  final baseRepositorio = BaseRepositorio();
  final String bannerUrl = '${baseRepositorio.BASE_API}:5005/banner-m.webp';
  final String logoUrl = '${baseRepositorio.BASE_API}:5005/logo.webp';

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
                bannerUrl,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.network(
                    logoUrl,
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