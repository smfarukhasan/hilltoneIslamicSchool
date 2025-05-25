import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';

class RoutinePageT extends StatefulWidget {
  const RoutinePageT({super.key});

  @override
  State<RoutinePageT> createState() => _RoutinePageTState();
}

class _RoutinePageTState extends State<RoutinePageT> {
  late String selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = getTodayInEnglish();
  }

  String getTodayInEnglish() {
    return DateFormat('EEEE').format(DateTime.now());
  }

  List<String> getDaysInLocale(AppLocalizations loc) {
    return [
      loc.saturday,
      loc.sunday,
      loc.monday,
      loc.tuesday,
      loc.wednesday,
      loc.thursday,
    ];
  }

  final Map<String, List<Map<String, String>>> routines = {
    'Saturday': [
      {
        'no': '1',
        'time': '8:00 - 9:00',
        'subject': 'Math',
        'class': 'Class 6'
      },
      {
        'no': '2',
        'time': '9:00 - 10:00',
        'subject': 'Bangla',
        'class': 'Class 7'
      },
    ],
    'Sunday': [
      {
        'no': '1',
        'time': '8:00 - 9:00',
        'subject': 'English',
        'class': 'Class 8'
      },
      {
        'no': '2',
        'time': '9:00 - 10:00',
        'subject': 'Religion',
        'class': 'Class 9'
      },
    ],
    // অন্যান্য দিন...
  };

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final days = getDaysInLocale(loc);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          loc.classRoutine,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: buildDayGrid(days),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(child: buildRoutineCard(selectedDay, loc)),
          ],
        ),
      ),
    );
  }

  Widget buildDayGrid(List<String> localizedDays) {
    final engDays = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday'
    ];
    return GridView.builder(
      itemCount: localizedDays.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 40,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final isSelected = selectedDay == engDays[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDay = engDays[index];
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.green[100] : Colors.green[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              localizedDays[index],
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildRoutineCard(String day, AppLocalizations loc) {
    final routine = routines[day] ?? [];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: routine.isEmpty
            ? Center(child: Text(loc.noRoutine))
            : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(color: Colors.green.shade900),
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(2),
            },
            defaultVerticalAlignment:
            TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                ),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "No.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      loc.time,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      loc.subject,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      loc.cclass, // New column header
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              ...routine.map((item) {
                return TableRow(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7F7F7),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        item['no']!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        item['time']!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        item['subject']!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        item['class']!, // New column data
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}