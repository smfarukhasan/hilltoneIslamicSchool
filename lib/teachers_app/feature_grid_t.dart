import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'pages_t/homework_t/homework_page_t.dart';
import 'pages_t/attendance_page_t.dart';
import 'pages_t/routine_page_t.dart';
import 'pages_t/syllabus_page_t.dart';
import 'pages_t/result_page_t.dart';
import 'pages_t/payment_page_t.dart';

class FeatureGridT extends StatelessWidget {
  const FeatureGridT({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final items = [
      _GridItem(loc.homework, Icons.sticky_note_2_outlined, () => _navigate(context, const HomeworkPageT())),
      _GridItem(loc.attendance, Icons.calendar_month_outlined, () => _navigate(context, const AttendancePageT())),
      _GridItem(loc.classRoutine, Icons.watch_later_outlined, () => _navigate(context, const RoutinePageT())),
      _GridItem(loc.syllabus, Icons.menu_book, () => _navigate(context, const SyllabusPageT())),
      _GridItem(loc.result, Icons.bar_chart, () => _navigate(context, const ResultPageT())),
      _GridItem(loc.payment, Icons.payment, () => _navigate(context, const PaymentPageT())),
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) => _buildTile(context, items[index]),
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, _GridItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green[400],
            radius: 28,
            child: Icon(item.icon, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
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
