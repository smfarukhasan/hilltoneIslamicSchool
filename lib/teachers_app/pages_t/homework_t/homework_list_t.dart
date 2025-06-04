import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';

class HomeworkListT extends StatefulWidget {
  final List<Map<String, String>> homeworks;
  final void Function(int) onDelete;
  final void Function(int, Map<String, String>) onEdit;

  const HomeworkListT({
    super.key,
    required this.homeworks,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<HomeworkListT> createState() => _HomeworkListTState();
}

class _HomeworkListTState extends State<HomeworkListT> {
  String searchText = '';
  String? selectedClass;
  String? selectedSection;
  String? selectedSubject;
  String? selectedDate;

  List<Map<String, String>> get filteredHomeworks {
    return widget.homeworks.where((hw) {
      final matchesSearch = searchText.isEmpty ||
          hw.values.any((value) => value.toLowerCase().contains(searchText.toLowerCase()));
      final matchesClass = selectedClass == null || hw['class'] == selectedClass;
      final matchesSection = selectedSection == null || hw['section'] == selectedSection;
      final matchesSubject = selectedSubject == null || hw['subject'] == selectedSubject;
      final matchesDate = selectedDate == null || hw['date'] == selectedDate;
      return matchesSearch && matchesClass && matchesSection && matchesSubject && matchesDate;
    }).toList();
  }

  List<String> getUniqueValues(String key) {
    return widget.homeworks
        .map((hw) => hw[key])
        .where((value) => value != null && value.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();
  }

  void _openFilterDialog() {
    final loc = AppLocalizations.of(context)!;
    String? tempClass = selectedClass;
    String? tempSection = selectedSection;
    String? tempSubject = selectedSubject;
    String? tempDate = selectedDate;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  loc.filter,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 20),

                _buildDropdown(loc.cclass, tempClass, getUniqueValues('class'), (val) => tempClass = val),
                const SizedBox(height: 12),

                _buildDropdown(loc.section, tempSection, getUniqueValues('section'), (val) => tempSection = val),
                const SizedBox(height: 12),

                _buildDropdown(loc.subject, tempSubject, getUniqueValues('subject'), (val) => tempSubject = val),
                const SizedBox(height: 12),

                _buildDropdown(loc.date, tempDate, getUniqueValues('date'), (val) => tempDate = val),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          selectedClass = null;
                          selectedSection = null;
                          selectedSubject = null;
                          selectedDate = null;
                        });
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.refresh, color: Colors.red),
                      label: Text(loc.reset, style: const TextStyle(color: Colors.red)),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          selectedClass = tempClass;
                          selectedSection = tempSection;
                          selectedSubject = tempSubject;
                          selectedDate = tempDate;
                        });
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: Text(loc.filter),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[300],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label,
      String? currentValue,
      List<String> items,
      void Function(String?) onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.teal.shade200),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<String>(
            value: currentValue,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(border: InputBorder.none),
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Search bar + Filter button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.15 * 255).toInt()),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) => setState(() => searchText = value),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                hintText: loc.search,
                hintStyle: TextStyle(color: Colors.teal[900]),
                prefixIcon: Icon(Icons.search, color: Colors.teal[900]),
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.teal[900]),
                  onPressed: _openFilterDialog,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),

        // List
        Expanded(
          child: filteredHomeworks.isEmpty
              ? Center(child: Text(loc.noHomeWork, style: const TextStyle(fontSize: 16)))
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            itemCount: filteredHomeworks.length,
            itemBuilder: (context, index) {
              final hw = filteredHomeworks[index];
              return _buildHomeworkCard(hw, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHomeworkCard(Map<String, String> hw, int index) {
    final loc = AppLocalizations.of(context)!;
    return Card(
      elevation: 3,
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
                    color: Colors.green.shade100,
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

            if (hw['description']?.isNotEmpty ?? false)
              Text(hw['description']!, style: const TextStyle(fontSize: 14)),

            if (hw['link']?.isNotEmpty ?? false) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _launchURL(hw['link']!),
                child: Text(
                  hw['link']!,
                  style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ],
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${loc.date}: ${hw['date'] ?? ''}', style: const TextStyle(color: Colors.grey)),
                Row(
                  children: [
                    _buildActionButton(Icons.edit_note, loc.edit, Colors.blue,
                            () => widget.onEdit(widget.homeworks.indexOf(hw), hw)),
                    const SizedBox(width: 8),
                    _buildActionButton(Icons.delete_forever, loc.delete, Colors.red,
                            () => widget.onDelete(widget.homeworks.indexOf(hw))),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon,
      String label,
      Color color,
      VoidCallback onPressed,
      ) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      style: TextButton.styleFrom(foregroundColor: color),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
