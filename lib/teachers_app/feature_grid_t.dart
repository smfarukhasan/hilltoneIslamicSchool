import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'pages_t/homework_t/homework_page_t.dart';
import 'pages_t/attendance_page_t.dart';
import 'pages_t/report_page_t.dart';
import 'pages_t/routine_page_t.dart';
import 'pages_t/result_submit/result_page_t.dart';
import 'pages_t/leave_apply/leave_page_t.dart';

class FeatureGridT extends StatelessWidget {
  const FeatureGridT({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final items = [
      _GridItem(loc.homework, Icons.menu_book, () => _navigate(context, const HomeworkPageT())),
      _GridItem(loc.attendance, Icons.calendar_month_outlined, () => _navigate(context, const AttendancePageT())),
      _GridItem(loc.classRoutine, Icons.watch_later_outlined, () => _navigate(context, const RoutinePageT())),
      _GridItem(loc.report, Icons.report_gmailerrorred, () => _navigate(context, const ReportPageT())),
      _GridItem(loc.result, Icons.bar_chart, () => _navigate(context, ResultPageT())),
      _GridItem(loc.leave, Icons.sticky_note_2_outlined, () => _navigate(context, const LeavePageT())),
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
            backgroundColor: Colors.green[400],
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
