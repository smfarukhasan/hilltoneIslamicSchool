import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'pages/homework_page.dart';
import 'pages/attendance_page.dart';
import 'pages/routine_page.dart';
import 'pages/syllabus_page.dart';
import 'pages/result_page.dart';
import 'pages/payment_page.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final items = [
      _GridItem(loc.homework, Icons.menu_book, () => _navigate(context, const HomeworkPage())),
      _GridItem(loc.attendance, Icons.calendar_month_outlined, () => _navigate(context, const AttendancePage())),
      _GridItem(loc.classRoutine, Icons.watch_later_outlined, () => _navigate(context, const RoutinePage())),
      _GridItem(loc.syllabus, Icons.picture_as_pdf_outlined, () => _navigate(context, const SyllabusPage())),
      _GridItem(loc.result, Icons.bar_chart, () => _navigate(context, const ResultPage())),
      _GridItem(loc.payment, Icons.payment, () => _navigate(context, const PaymentPage())),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double spacing = 8;
        double aspectRatio = width > 400 ? 0.85 : 0.9;

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.all(4),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing / 2,
                childAspectRatio: aspectRatio,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) => _buildTile(context, items[index]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTile(BuildContext context, _GridItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal[400],
            radius: 26,
            child: Icon(item.icon, size: 26, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}

class _GridItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  _GridItem(this.title, this.icon, this.onTap);
}
