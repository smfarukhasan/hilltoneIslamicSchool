class LeaveModel {
  final String type;
  final String fromDate;
  final String toDate;
  final String description;
  final int statusFlag; // 1 = Pending, 2 = Accepted, 3 = Rejected

  LeaveModel({
    required this.type,
    required this.fromDate,
    required this.toDate,
    required this.description,
    this.statusFlag = 1, // 1 = Pending, 2 = Accepted, 3 = Rejected
  });
}
