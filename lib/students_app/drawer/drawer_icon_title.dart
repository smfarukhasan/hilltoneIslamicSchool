import 'package:flutter/material.dart';

class DrawerTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerTitle({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; // Adjust breakpoint as needed

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 12 : 0, vertical: 2),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal.shade50,
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          splashColor: Colors.tealAccent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: isTablet ? 24 : 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}