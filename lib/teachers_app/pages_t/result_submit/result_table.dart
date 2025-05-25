import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'state_manager.dart';

class ResultTable extends StatelessWidget {
  final ResultStateManager manager;

  const ResultTable({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: manager,
      builder: (context, _) {
        if (!manager.isFormSubmitted) return const SizedBox();

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                  loc.schoolName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 10),
              _buildHeaderInfo(screenWidth),
              const SizedBox(height: 10),
              _buildTableHeader(),
              const SizedBox(height: 6),
              ...manager.studentList.asMap().entries.map((entry) {
                final index = entry.key;
                final student = entry.value;
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text('${index + 1}')),
                        Expanded(flex: 2, child: Text(student.id)),
                        Expanded(flex: 4, child: Text(student.name)),
                        Expanded(
                          flex: 2,
                          child: Text(
                            student.marks,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderInfo(double screenWidth) {
    TextStyle infoStyle = TextStyle(fontSize: screenWidth * 0.038);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 8,
        children: [
          Text('শিক্ষাবর্ষ: ${manager.selectedSession ?? ''}', style: infoStyle),
          Text('পরীক্ষা: ${manager.selectedExam ?? ''}', style: infoStyle),
          Text('ক্লাস: ${manager.selectedClass ?? ''}', style: infoStyle),
          Text('সেকশন: ${manager.selectedSection ?? ''}', style: infoStyle),
          Text('বিষয়: ${manager.selectedSubject ?? ''}', style: infoStyle),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: const Row(
        children: [
          Expanded(flex: 1, child: Text('No.', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('আইডি', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 4, child: Text('নাম', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('প্রাপ্ত নম্বর', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      )
    );
  }
}
