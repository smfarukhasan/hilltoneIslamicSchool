import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';

class HomeworkPage extends StatefulWidget {
  const HomeworkPage({super.key});

  @override
  State<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  DateTime selectedDate = DateTime.now();

  final List<Map<String, String>> homeworks = [
    {
      'class': '8',
      'section': 'A',
      'subject': 'Math',
      'type': 'Homework',
      'description': 'Solve quadratic equations from book',
      'link': 'https://example.com/math-homework',
      'date': '2025-05-16',
    },
    {
      'class': '9',
      'section': 'B',
      'subject': 'Bangla',
      'type': 'Classwork',
      'description': 'Write a biography of Kazi Nazrul Islam',
      'link': '',
      'date': '2025-05-15',
    },
    {
      'class': '10',
      'section': 'C',
      'subject': 'English',
      'type': 'Homework',
      'description': 'Write a paragraph on "My School"',
      'link': 'https://example.com/english-paragraph',
      'date': '2025-05-14',
    },
  ];

  List<Map<String, String>> get filteredHomeworks {
    String selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
    return homeworks.where((hw) => hw['date'] == selectedDateStr).toList();
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      helpText: 'Select Date',
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final formattedDate = DateFormat('dd MMM yyyy').format(selectedDate); // ইংরেজিতে

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[600],
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          loc.hwAndCw,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNavButton(Icons.chevron_left, () => _changeDate(-1)),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.teal[200],
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade900,
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
                          formattedDate,
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
                const SizedBox(width: 12),
                _buildNavButton(Icons.chevron_right, () => _changeDate(1)),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Homework Cards
          Expanded(
            child: filteredHomeworks.isEmpty
                ? Center(
              child: Text(
                loc.noHomeWork,
                style: const TextStyle(fontSize: 16),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: filteredHomeworks.length,
              itemBuilder: (context, index) {
                final hw = filteredHomeworks[index];
                return _buildHomeworkCard(hw);
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildNavButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.teal[400],
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

  Widget _buildHomeworkCard(Map<String, String> hw) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject + Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hw['subject'] ?? '',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    hw['type'] ?? '',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            if ((hw['description'] ?? '').isNotEmpty)
              Text(hw['description']!, style: const TextStyle(fontSize: 14)),

            if ((hw['link'] ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _launchURL(hw['link']!),
                child: Text(
                  hw['link']!,
                  style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
