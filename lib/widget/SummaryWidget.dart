class SummaryWidget {
  final double approvedProgress;
  final double pendingProgress;
  final double rejectedProgress;
  final int stationery;
  final int affective_score;
  final int certificate;

  SummaryWidget({
    required this.approvedProgress,
    required this.pendingProgress,
    required this.rejectedProgress,
    required this.stationery,
    required this.affective_score,
    required this.certificate,
  });
}
