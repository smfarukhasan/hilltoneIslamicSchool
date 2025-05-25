import 'package:flutter/material.dart';
import '../../global_functions/snack_bar.dart';
import '../../l10n/app_localizations.dart';

class ReportPageT extends StatefulWidget {
  const ReportPageT({super.key});

  @override
  State<ReportPageT> createState() => _ReportPageTState();
}

class _ReportPageTState extends State<ReportPageT> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      _titleController.text.trim();
      _subjectController.text.trim();
      _detailsController.text.trim();

      FocusScope.of(context).unfocus();

      _titleController.clear();
      _subjectController.clear();
      _detailsController.clear();

      showGlobalSnackBar(context,AppLocalizations.of(context)!.reportSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          loc.report,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: loc.reportTitle,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return loc.titleRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: loc.reportSubject,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.subject),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return loc.subjectRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(
                  labelText: loc.reportDetails,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return loc.detailsRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitReport,
                icon: const Icon(Icons.send, color: Colors.white),
                label: Text(
                  loc.submit,
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
