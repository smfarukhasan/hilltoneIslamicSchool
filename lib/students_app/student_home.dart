import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'drawer/app_drawer.dart';
import 'feature_grid.dart';
import 'nev_bar/bottom_nav.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Top Banner
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  // Drawer icon
                  Builder(
                    builder: (ctx) => IconButton(
                      icon: const Icon(Icons.menu_rounded, color: Colors.white),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                  const SizedBox(width: 1),
                  Image.asset('assets/logo.png', height: 120),
                  const SizedBox(width: 1),
                  Expanded(
                    child: Text(
                      loc.schoolName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔸 Overlapping Card
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 300,
                    child: const Row(
                      children: [
                        Expanded(child: FeatureGrid()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
            ),
            // 🔹 Bottom Navigation
            const BottomNav(currentIndex: 0),
          ],
        ),
      ),
    );
  }
}
