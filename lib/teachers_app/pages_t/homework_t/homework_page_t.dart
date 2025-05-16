import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'homework_form_t.dart';
import 'homework_list_t.dart';

class HomeworkPageT extends StatefulWidget {
  const HomeworkPageT({super.key});

  @override
  State<HomeworkPageT> createState() => _HomeworkPageTState();
}

class _HomeworkPageTState extends State<HomeworkPageT> with TickerProviderStateMixin {
  bool showForm = true;
  late final TabController _tabController;
  List<Map<String, String>> homeworkList = [];

  int? editingIndex;
  Map<String, String>? editingData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        showForm = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleSave(Map<String, String> data) {
    setState(() {
      if (editingIndex != null) {
        // আপডেট
        homeworkList[editingIndex!] = data;
        editingIndex = null;
        editingData = null;
      } else {
        // নতুন
        homeworkList.insert(0, data);
      }
      _tabController.animateTo(1); // ফর্ম শেষে লিস্টে ফিরো
    });
  }

  void deleteHomework(int index) {
    setState(() {
      homeworkList.removeAt(index);
    });
  }

  void editHomework(int index, Map<String, String> data) {
    setState(() {
      editingIndex = index;
      editingData = data;
      _tabController.animateTo(0); // ফর্ম দেখাও
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // extendBody: true,

      body: Column(
        children: [
          SafeArea(
            child: Material(
              elevation: 2,
              child: TabBar(
                controller: _tabController,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.green,
                labelColor: Colors.green,
                unselectedLabelColor: theme.textTheme.bodyMedium?.color,
                tabs: [
                  Tab(text: loc.homework),
                  const Tab(text: "HW List"),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HomeworkFormT(
                  key: ValueKey(editingIndex ?? -1),
                  onSave: handleSave,
                  isEditing: editingData != null,
                  initialData: editingData,
                ),
                HomeworkListT(
                  homeworks: homeworkList,
                  onDelete: deleteHomework,
                  onEdit: editHomework,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () => Navigator.of(context).pop(),
                color: Colors.green.shade700,
                tooltip: 'Back',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
