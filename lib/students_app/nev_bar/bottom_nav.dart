import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'notice_page.dart';
import 'profile_page.dart';
import '../student_home.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;

  const BottomNav({super.key, required this.currentIndex});

  void _navigateTo(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget destination;
    switch (index) {
      case 0:
        destination = const StudentHome();
        break;
      case 1:
        destination = const NoticePage();
        break;
      case 2:
        destination = const ProfilePage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => destination,
        transitionsBuilder: (_, animation, __, child) {
          final isForward = index > currentIndex;
          final begin = Offset(isForward ? 1.0 : -1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Material(
          elevation: 10,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (i) => _navigateTo(context, i),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.teal[400],
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black87,
            selectedFontSize: 15,
            unselectedFontSize: 12,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            iconSize: 30,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home, color: Colors.white),
                label: loc.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.note_alt_outlined),
                activeIcon: const Icon(Icons.note_alt, color: Colors.white),
                label: loc.notices,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person, color: Colors.white),
                label: loc.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
