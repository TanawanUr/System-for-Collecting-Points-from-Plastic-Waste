class StaffRewardRequestListWidget {
  final int requestId;
  final String e_passport;
  final String fullname;
  final String faculty;
  final String department;

  final int points;
  final String itemName;
  final int itemQuantity;
  final String itemImageUrl;

  final DateTime date;
  final DateTime? submitedDate;
  final String? reason;
  final String status;

  StaffRewardRequestListWidget({
    required this.requestId,
    required this.e_passport,
    required this.fullname,
    required this.faculty,
    required this.department,

    this.points = 0,
    required this.itemName,
    required this.itemQuantity,
    required this.itemImageUrl,

    required this.date,
    this.submitedDate,
    this.reason = '-',
    required this.status,
  });
}
