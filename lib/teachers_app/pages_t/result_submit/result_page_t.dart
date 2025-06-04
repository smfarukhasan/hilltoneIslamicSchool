import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'dropdown_section.dart';
import 'student_input_section.dart';
import 'result_table.dart';
import 'state_manager.dart';

class ResultPageT extends StatelessWidget {
  ResultPageT({super.key});

  final ResultStateManager manager = ResultStateManager();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          loc.result,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          // scrollable content: only ResultTable
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: AnimatedBuilder(
                animation: manager,
                builder: (context, _) {
                  if (!manager.isFormSubmitted) {
                    return Center(
                        child: Text(loc.marksSubmit));
                  }
                  return ResultTable(manager: manager);
                },
              ),
            ),
          ),

          // Fixed bottom: Dropdown or Student Input
          AnimatedBuilder(
            animation: manager,
            builder: (context, _) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: const Border(top: BorderSide(color: Colors.black)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((255 * 0.05).toInt()),
                      offset: const Offset(0, -1),
                      blurRadius: 4,
                    )
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: manager.isFormSubmitted
                    ? Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: StudentInputSection(manager: manager),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          manager.resetSelection();
                        },
                      ),
                    ),
                  ],
                )
                    : DropdownSection(manager: manager),
              );
            },
          ),
        ],
      ),
    );
  }
}
