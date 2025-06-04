import 'package:flutter/material.dart';
import '../../../global_functions/snack_bar.dart';
import '../../../l10n/app_localizations.dart';
import 'state_manager.dart';

class StudentInputSection extends StatefulWidget {
  final ResultStateManager manager;
  const StudentInputSection({super.key, required this.manager});

  @override
  State<StudentInputSection> createState() => _StudentInputSectionState();
}

class _StudentInputSectionState extends State<StudentInputSection> {
  late TextEditingController marksController;

  @override
  void initState() {
    super.initState();
    marksController = TextEditingController(text: widget.manager.currentStudent.marks);
    widget.manager.addListener(_onManagerChange);
  }

  void _onManagerChange() {
    final currentMarks = widget.manager.currentStudent.marks;
    if (marksController.text != currentMarks) {
      marksController.text = currentMarks;
    }
    setState(() {});
  }

  @override
  void dispose() {
    widget.manager.removeListener(_onManagerChange);
    marksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final manager = widget.manager;
    final student = manager.currentStudent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('  ${loc.name}: ${student.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('  ${loc.id}: ${student.id}', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        TextField(
          controller: marksController,
          keyboardType: TextInputType.number,
          enabled: !manager.isInputLocked,
          decoration: InputDecoration(
            labelText: loc.enterMarks,
            hintText: loc.enterMarks,
            prefixIcon: const Icon(Icons.edit),
            filled: true,
            fillColor: manager.isInputLocked ? Colors.grey[200] : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) {
            manager.updateMarks(value);
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: manager.currentStudentIndex > 0 ? manager.previousStudent : null,
                icon: const Icon(Icons.arrow_back),
                label: Text(loc.previousStudent),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: manager.currentStudentIndex < manager.studentList.length - 1
                    ? manager.nextStudent
                    : null,
                icon: const Icon(Icons.arrow_forward),
                label: Text(loc.nextStudent),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: manager.isInputLocked ? null : () => _showConfirmationDialog(context),
              icon: const Icon(Icons.check_circle),
              label: Text(loc.submit, style: const TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.warning_amber_rounded, size: 60, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      loc.areYouSure,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      loc.confirmSubmissionWarning,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.manager.updateMarks(marksController.text);
                              widget.manager.lockInput();
                              showGlobalSnackBar(context,loc.marksSavedSuccessfully);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(loc.submit),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(loc.cancel),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
