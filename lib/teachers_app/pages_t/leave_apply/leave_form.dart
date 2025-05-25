import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';
import 'leave_model.dart';

class LeaveForm extends StatefulWidget {
  const LeaveForm({super.key});

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _descController = TextEditingController();
  final _nameController = TextEditingController();

  DateTime? _fromDate;
  DateTime? _toDate;

  Future<void> _selectDate(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _fromDate != null &&
        _toDate != null) {
      final leave = LeaveModel(
        type: _typeController.text.trim(),
        fromDate: DateFormat('dd-MMM-yyyy').format(_fromDate!),
        toDate: DateFormat('dd-MMM-yyyy').format(_toDate!),
        description: _descController.text.trim(),
      );
      Navigator.of(context).pop(leave);
    }
  }

  @override
  void dispose() {
    _typeController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SizedBox(
      width: 350,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              loc.newLeaveRequest,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _selectDate(true),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.green.shade500,
                    ),
                    child: Text(
                      _fromDate == null
                          ? loc.fromDate
                          : DateFormat('dd-MMM-yyyy').format(_fromDate!),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _selectDate(false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.green.shade500,
                    ),
                    child: Text(
                      _toDate == null
                          ? loc.toDate
                          : DateFormat('dd-MMM-yyyy').format(_toDate!),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: loc.name,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) =>
              value!.isEmpty ? loc.enterName : null,
            ),
            const SizedBox(height: 12),

            /// 📝 ছুটির ধরন
            TextFormField(
              controller: _typeController,
              decoration: InputDecoration(
                labelText: loc.leaveType,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) =>
              value!.isEmpty ? loc.enterLeaveType : null,
            ),
            const SizedBox(height: 12),

            /// 🧾 বর্ণনা
            TextFormField(
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: loc.description,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) =>
              value!.isEmpty ? loc.enterDescription : null,
            ),
            const SizedBox(height: 16),

            /// ✅ সাবমিট বাটন
            ElevatedButton.icon(
              icon: const Icon(Icons.check, color: Colors.white),
              label: Text(
                loc.submit,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade500,
                minimumSize: const Size(double.infinity, 48),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // কম গোলাকৃতি কোণা
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
