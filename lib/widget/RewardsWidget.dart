class RewardsWidget {
  final int rewardId;
  final int points;
  final String itemName;
  final int itemQuantity;
  final String itemImageUrl;

  RewardsWidget({
    required this.rewardId,
    this.points = 0, 
    required this.itemName,
    required this.itemQuantity,
    required this.itemImageUrl,
  });
}