import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'leave_form.dart';
import 'leave_model.dart';

class LeavePageT extends StatefulWidget {
  const LeavePageT({super.key});

  @override
  State<LeavePageT> createState() => _LeavePageTState();
}

class _LeavePageTState extends State<LeavePageT> {
  final List<LeaveModel> _leaveList = [];

  void _openLeaveDialog() async {
    final result = await showDialog<LeaveModel>(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: const LeaveForm(),
      ),
    );

    if (result != null) {
      setState(() {
        _leaveList.insert(0, result);
      });
    }
  }

  String _statusText(int statusFlag) {
    switch (statusFlag) {
      case 1:
        return "Pending";
      case 2:
        return "Accepted";
      case 3:
        return "Rejected";
      default:
        return "Unknown";
    }
  }

  Color _statusColor(int statusFlag) {
    switch (statusFlag) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
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
          loc.leave,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _openLeaveDialog,
          ),
        ],
      ),

      body: _leaveList.isEmpty
          ? Center(child: Text(loc.noLeaveApplications))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _leaveList.length,
        itemBuilder: (context, index) {
          final leave = _leaveList[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(leave.type,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${leave.fromDate} - ${leave.toDate}"),
                  const SizedBox(height: 4),
                  Text(leave.description),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _statusColor(leave.statusFlag),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _statusText(leave.statusFlag),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
