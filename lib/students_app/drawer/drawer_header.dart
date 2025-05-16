import 'package:flutter/material.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double headerHeight = screenWidth * 0.5;
    final double imageSize = headerHeight * 0.5;

    return Container(
      height: headerHeight,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.teal[600],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🔹 প্রোফাইল ইমেজ
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white24,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              'assets/profile.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white24,
                  child: Icon(
                    Icons.person,
                    size: imageSize * 0.6,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 5),

          // 🔹 নাম
          const Text(
            'John Doe',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          // 🔹 আইডি
          const SizedBox(height: 1),
          const Text(
            'ID: 12345',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}