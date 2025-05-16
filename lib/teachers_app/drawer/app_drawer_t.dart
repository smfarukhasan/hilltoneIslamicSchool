import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../login/logout_page.dart';
import '../../students_app/drawer/drawer_icon_title.dart';
import 'drawer_header_t.dart';
import 'settings_dialog_t.dart';

class AppDrawerT extends StatelessWidget {
  const AppDrawerT({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.70,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const AppDrawerHeaderT(),

            DrawerTitle(
              icon: Icons.home,
              title: loc.home,
              onTap: () => Navigator.pop(context),
            ),

            DrawerTitle(
              icon: Icons.announcement,
              title: loc.notices,
              onTap: () => Navigator.pop(context),
            ),

            DrawerTitle(
              icon: Icons.settings,
              title: loc.settings,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const SettingsDialog(), // ← ডায়ালগ কল
                );
              },
            ),

            DrawerTitle(
              icon: Icons.power_settings_new,
              title: loc.logout,
              onTap: () {
                showLogoutSheet(context); // 🔄 নিচে ফাংশন কল
              },
            ),
          ],
        ),
      ),
    );
  }
}
