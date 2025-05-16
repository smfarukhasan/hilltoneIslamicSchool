import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeworkFormT extends StatefulWidget {
  final Function(Map<String, String>) onSave;
  final Map<String, String>? initialData;
  final bool isEditing;

  const HomeworkFormT({
    Key? key,
    required this.onSave,
    this.initialData,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<HomeworkFormT> createState() => _HomeworkFormTState();
}

class _HomeworkFormTState extends State<HomeworkFormT> {
  String? selectedClass, selectedSection, selectedSubject;
  String type = 'Homework';
  final TextEditingController description = TextEditingController();
  final TextEditingController link = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.isEditing && widget.initialData != null) {
      final data = widget.initialData!;
      selectedClass = data['class'];
      selectedSection = data['section'];
      selectedSubject = data['subject'];
      type = data['type'] ?? 'Homework';
      description.text = data['description'] ?? '';
      link.text = data['link'] ?? '';
      selectedDate = DateTime.tryParse(data['date'] ?? '') ?? DateTime.now();
    }
  }

  final List<String> classes = ['1', '2', '3'];
  final Map<String, List<String>> sections = {
    '1': ['A', 'B'],
    '2': ['A'],
    '3': ['B']
  };
  final Map<String, List<String>> subjects = {
    '1': ['Math', 'Bangla'],
    '2': ['English'],
    '3': ['Science']
  };

  void _handleSave() {
    FocusScope.of(context).unfocus();

    if (selectedClass != null &&
        selectedSection != null &&
        selectedSubject != null &&
        description.text.trim().isNotEmpty) {
      final data = {
        'class': selectedClass!,
        'section': selectedSection!,
        'subject': selectedSubject!,
        'type': type,
        'description': description.text,
        'link': link.text,
        'date': DateFormat('yyyy-MM-dd').format(selectedDate),
      };
      widget.onSave(data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ হোমওয়ার্ক সংরক্ষণ করা হয়েছে')),
      );

      // সব ক্লিয়ার করা
      setState(() {
        selectedClass = null;
        selectedSection = null;
        selectedSubject = null;
        type = 'Homework';
        description.clear();
        link.clear();
        selectedDate = DateTime.now();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ অনুগ্রহ করে সব বাধ্যতামূলক ফিল্ড পূরণ করুন')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_outlined, color: Colors.green.shade700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        DateFormat('dd-MM-yyyy').format(selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.green.shade700,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black87,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.green.shade700,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) setState(() => selectedDate = picked);
                      },
                      icon: Icon(Icons.edit_calendar_outlined, color: Colors.green.shade700),
                      label: Text(
                        'তারিখ পরিবর্তন',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   'হোমওয়ার্কের ধরন',
                  //   style: Theme.of(context).textTheme.titleMedium,
                  // ),
                  // const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: 'Homework',
                            groupValue: type,
                            activeColor: Colors.green,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('হোমওয়ার্ক'),
                            onChanged: (val) => setState(() => type = val!),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: 'Classwork',
                            groupValue: type,
                            activeColor: Colors.green,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('ক্লাসওয়ার্ক'),
                            onChanged: (val) => setState(() => type = val!),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                label: 'ক্লাস',
                value: selectedClass,
                items: classes,
                onChanged: (val) {
                  setState(() {
                    selectedClass = val;
                    selectedSection = null;
                    selectedSubject = null;
                  });
                },
              ),
              const SizedBox(height: 10),
              if (selectedClass != null)
                _buildDropdown(
                  label: 'সেকশন *',
                  value: selectedSection,
                  items: sections[selectedClass]!,
                  onChanged: (val) => setState(() => selectedSection = val),
                ),
              const SizedBox(height: 10),
              if (selectedClass != null && selectedSection != null)
                _buildDropdown(
                  label: 'বিষয় *',
                  value: selectedSubject,
                  items: subjects[selectedClass]!,
                  onChanged: (val) => setState(() => selectedSubject = val),
                ),
              const SizedBox(height: 10),
              _buildTextField(controller: description, label: 'বিবরণ *', maxLines: 3),
              const SizedBox(height: 10),
              _buildTextField(controller: link, label: 'লিঙ্ক (ঐচ্ছিক)'),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _handleSave,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green, // ✅ সবুজ ব্যাকগ্রাউন্ড
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    'সেভ করুন',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      maxLines: maxLines,
    );
  }
}
