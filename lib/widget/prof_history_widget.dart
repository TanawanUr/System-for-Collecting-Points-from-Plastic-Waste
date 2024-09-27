class ProfessorHistory {
  final String e_passport;
  final String fullname;
  final String faculty;
  final String department;
  final String subject;
  final DateTime date;
  final String reason;
  final String status;


  ProfessorHistory({
    required this.e_passport,
    required this.fullname,
    required this.faculty,
    required this.department,
    required this.subject,
    required this.date,
    this.reason = '-',
    required this.status,
  });
}
