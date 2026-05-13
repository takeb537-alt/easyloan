class PenaltyCalculator {
  static double getBasePenalty(double principal) {
    if (principal <= 100) return 50;
    if (principal <= 500) return 100;
    if (principal <= 1000) return 200;
    if (principal <= 1500) return 250;
    return 300;
  }

  static double calculateCurrentPenalty(double principal, DateTime dueDate) {
    final daysOverdue = DateTime.now().difference(dueDate).inDays;
    if (daysOverdue <= 5) return 0;

    double base = getBasePenalty(principal);
    if (daysOverdue <= 10) return base * 0.25;
    if (daysOverdue <= 15) return base * 0.50;
    if (daysOverdue <= 20) return base * 0.75;
    if (daysOverdue <= 25) return base * 1.0;
    if (daysOverdue <= 30) return base * 2.0;
    return base * 5.0; // Escalated after 30 days
  }
}
