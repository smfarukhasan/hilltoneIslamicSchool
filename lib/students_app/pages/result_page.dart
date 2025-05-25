import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String? selectedExam;
  bool showTable = false;

  final List<String> exams = ['Mid Term', 'Final', 'Class Test'];
  final List<Map<String, dynamic>> results = [
    {'subject': 'গণিত', 'marks': 80, 'grade': 'A'},
    {'subject': 'বাংলা', 'marks': 75, 'grade': 'A-'},
    {'subject': 'ইংরেজি', 'marks': 65, 'grade': 'B+'},
  ];

  double get averageMarks => results.map((e) => e['marks'] as int).reduce((a, b) => a + b) / results.length;

  String get averageGrade {
    final grades = ['A+', 'A', 'A-', 'B+', 'B', 'C', 'D', 'F'];
    final gradePoints = {
      'A+': 5.0,
      'A': 4.5,
      'A-': 4.0,
      'B+': 3.5,
      'B': 3.0,
      'C': 2.5,
      'D': 2.0,
      'F': 0.0,
    };

    final totalPoints = results.map((e) => gradePoints[e['grade']] ?? 0.0).reduce((a, b) => a + b);
    final avg = totalPoints / results.length;

    String closestGrade = grades.first;
    double minDiff = double.infinity;
    for (var g in grades) {
      double diff = (gradePoints[g]! - avg).abs();
      if (diff < minDiff) {
        minDiff = diff;
        closestGrade = g;
      }
    }

    return closestGrade;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          loc.result,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            // Dropdown + Search Row
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedExam,
                    decoration: const InputDecoration(
                      labelText: 'পরীক্ষার নাম',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    items: exams.map((exam) {
                      return DropdownMenuItem(value: exam, child: Text(exam));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedExam = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    if (selectedExam != null) {
                      setState(() {
                        showTable = true;
                      });
                    }
                  },
                  icon: const Icon(Icons.search, color: Colors.white),
                  label: const Text(
                    'অনুসন্ধান করুন',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black45,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 10),

            if (showTable) Expanded(child: _buildTable(context, screenWidth)),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context, double screenWidth) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Table(
        border: TableBorder.all(color: Colors.black, width: 1),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(4),
          2: FlexColumnWidth(3),
          3: FlexColumnWidth(2),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          // Header Row
          TableRow(
            decoration: BoxDecoration(color: Colors.teal[200]),
            children: const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('No.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('বিষয়', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('প্রাপ্ত নম্বর', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('গ্রেড', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),

          // Data Rows
          ...results.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final data = entry.value;

            return TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('$index', textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(data['subject'], textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('${data['marks']}', textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(data['grade'], textAlign: TextAlign.center),
              ),
            ]);
          }).toList(),

          // Summary Row
          TableRow(children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('মোট', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Padding(padding: EdgeInsets.all(8), child: Text('')),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(averageMarks.toStringAsFixed(2), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(averageGrade, textAlign: TextAlign.center),
            ),
          ]),
        ],
      ),
    );
  }
}
