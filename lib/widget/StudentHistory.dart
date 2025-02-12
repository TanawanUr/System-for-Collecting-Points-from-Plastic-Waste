class StudentHistory {
  final String type; // "collect" or "trade"
  final String itemName;
  // final String description;
  final DateTime date;
  final DateTime? submitedDate;
  final String status; // "approved", "pending", "canceled", etc.
  final int points; // for "collect" type
  final int itemQuantity;
  final String itemImageUrl;
  final String reason;

  StudentHistory({
    required this.type,
    required this.itemName,
    // required this.description,
    required this.date,
    this.submitedDate,
    required this.status,
    this.points = 0, // default to 0 if not applicable
    required this.itemQuantity,
    required this.itemImageUrl,
    this.reason = '-',
  });
}
