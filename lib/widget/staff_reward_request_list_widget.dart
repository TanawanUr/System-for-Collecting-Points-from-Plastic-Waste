class StaffRewardRequestListWidget {
  final String e_passport;
  final String fullname;
  final String faculty;
  final String department;

  final int points;
  final String itemName;
  final int itemQuantity;
  final String itemImageUrl;

  final DateTime date;

  StaffRewardRequestListWidget({
    required this.e_passport,
    required this.fullname,
    required this.faculty,
    required this.department,

    required this.points,
    required this.itemName,
    required this.itemQuantity,
    required this.itemImageUrl,

    required this.date,
  });
}
