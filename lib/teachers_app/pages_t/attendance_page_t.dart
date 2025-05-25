import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';

class AttendancePageT extends StatefulWidget {
  const AttendancePageT({super.key});

  @override
  State<AttendancePageT> createState() => _AttendancePageTState();
}

class _AttendancePageTState extends State<AttendancePageT> {
  DateTime selectedMonth = DateTime.now();

  List<Map<String, String>> generateAttendanceList(DateTime month) {
    final localeCode = Localizations.localeOf(context).toLanguageTag();
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    return List.generate(daysInMonth, (index) {
      final date = DateTime(month.year, month.month, index + 1);
      return {
        'date': DateFormat('d MMMM', localeCode).format(date),
        'checkIn': (index % 2 == 0) ? '9:00 AM' : '--',
        'checkOut': (index % 2 == 0) ? '3:30 PM' : '--',
      };
    });
  }

  void _changeMonth(int direction) {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + direction);
    });
  }

  Future<void> _pickMonth(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'মাস ও বছর নির্বাচন করুন',
      fieldHintText: 'মাস/বছর',
    );

    if (picked != null) {
      setState(() {
        selectedMonth = DateTime(picked.year, picked.month);
      });
    }
  }

  Widget _buildNavButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.green[400],
      shape: const CircleBorder(),
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Icon(icon, color: Colors.white, size: 35),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final attendanceList = generateAttendanceList(selectedMonth);
    final localeCode = Localizations.localeOf(context).toLanguageTag();
    final monthLabel = DateFormat('MMMM yyyy', localeCode).format(selectedMonth);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          loc.attendance,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNavButton(Icons.chevron_left, () => _changeMonth(-1)),
                const SizedBox(width: 8),

                // Month picker button
                GestureDetector(
                  onTap: () => _pickMonth(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade900,
                          offset: const Offset(0, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined, size: 18, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          monthLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),
                _buildNavButton(Icons.chevron_right, () => _changeMonth(1)),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            color: Colors.green.shade200,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    loc.date,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    loc.checkIn,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    loc.checkOut,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attendanceList.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = attendanceList[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item['date']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item['checkIn']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: item['checkIn'] == '--' ? Colors.grey : Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item['checkOut']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: item['checkOut'] == '--' ? Colors.grey : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
