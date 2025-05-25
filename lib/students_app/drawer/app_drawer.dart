import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../login/logout_page.dart';
import '../pages/homework_page.dart';
import '../pages/routine_page.dart';
import '../pages/syllabus_page.dart';
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
              icon: Icons.home,
              title: loc.home,
              onTap: () => Navigator.pop(context),
            ),

            DrawerTitle(
              icon: Icons.access_time_filled_sharp,
              title: loc.classRoutine,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RoutinePage()),
                );
              },
            ),

            DrawerTitle(
              icon: Icons.menu_book,
              title: loc.homework,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeworkPage()),
                );
              },
            ),

            DrawerTitle(
              icon: Icons.picture_as_pdf,
              title: loc.syllabus,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SyllabusPage()),
                );
              },
            ),

            DrawerTitle(
              icon: Icons.settings,
              title: loc.settings,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const SettingsDialog(),
                );
              },
            ),

            DrawerTitle(
              icon: Icons.power_settings_new,
              title: loc.logout,
              onTap: () {
                showLogoutSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
