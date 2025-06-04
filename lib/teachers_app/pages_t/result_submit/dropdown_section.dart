import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'state_manager.dart';

class DropdownSection extends StatelessWidget {
  final ResultStateManager manager;

  const DropdownSection({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: manager,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              _buildDropdownRow([
                _buildDropdownField(
                  label: loc.examName,
                  icon: Icons.assignment_outlined,
                  value: manager.selectedExam,
                  items: manager.examList,
                  onChanged: manager.setExam,
                ),
                _buildDropdownField(
                  label: loc.academicYear,
                  icon: Icons.calendar_month_outlined,
                  value: manager.selectedSession,
                  items: manager.selectedExam == null ? [] : manager.sessionList,
                  onChanged: manager.selectedExam == null ? null : manager.setSession,
                ),
              ]),
              const SizedBox(height: 10),
              _buildDropdownRow([
                _buildDropdownField(
                  label: loc.cclass,
                  icon: Icons.book_outlined,
                  value: manager.selectedClass,
                  items: manager.selectedSession == null ? [] : manager.classList,
                  onChanged: manager.selectedSession == null ? null : manager.setClass,
                ),
                _buildDropdownField(
                  label: loc.section,
                  icon: Icons.group,
                  value: manager.selectedSection,
                  items: manager.selectedClass == null ? [] : manager.sectionList,
                  onChanged: manager.selectedClass == null ? null : manager.setSection,
                ),
              ]),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildDropdownField(
                      label: loc.subject,
                      icon: Icons.subject,
                      value: manager.selectedSubject,
                      items: manager.selectedClass == null ? [] : manager.subjectList,
                      onChanged: manager.selectedClass == null ? null : manager.setSubject,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton.icon(
                      onPressed: _canSubmit() ? manager.submitForm : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.check_circle),
                      label: Text(loc.submit, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  bool _canSubmit() {
    return manager.selectedExam != null &&
        manager.selectedSession != null &&
        manager.selectedClass != null &&
        manager.selectedSection != null &&
        manager.selectedSubject != null;
  }

  Widget _buildDropdownRow(List<Widget> children) {
    return Row(
      children: [
        for (int i = 0; i < children.length; i++) ...[
          Expanded(child: children[i]),
          if (i < children.length - 1) const SizedBox(width: 12),
        ]
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?)? onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }
}
