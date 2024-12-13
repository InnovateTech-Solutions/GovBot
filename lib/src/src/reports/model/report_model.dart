class Report {
  final String reportId;
  final String title;
  final String description;
  final DateTime createdAt;

  Report({
    required this.reportId,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportId: json['_id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']['\$date']),  // Parsing created_at
    );
  }
}
