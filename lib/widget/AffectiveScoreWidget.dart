class AffectiveScoreWidget {
    final int rewardId;
  final int points;
  final String itemName;
  final int itemQuantity;

  AffectiveScoreWidget({
    required this.rewardId,
    this.points = 0, 
    required this.itemName,
    required this.itemQuantity,
  });
}