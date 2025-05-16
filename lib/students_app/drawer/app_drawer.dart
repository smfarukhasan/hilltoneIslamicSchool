import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../login/logout_page.dart';
import 'drawer_header.dart';
import 'drawer_icon_title.dart';
import 'settings_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: Colors.black12,
      width: MediaQuery.of(context).size.width * 0.70,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const AppDrawerHeader(),
            const SizedBox(height: 3),
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
