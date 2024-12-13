
class HistoryItem {
  final String id;
  final String userId;
  final String text;
  final String result;
  final List<String> citations;
  final List<String> inconsistencies;
  final List<String> origin;
  final double confidence;

  HistoryItem({
    required this.id,
    required this.userId,
    required this.text,
    required this.result,
    required this.citations,
    required this.inconsistencies,
    required this.origin,
    required this.confidence,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['_id']['\$oid'],
      userId: json['user_id'],
      text: json['text'],
      result: json['result'],
      citations: List<String>.from(json['citations'] ?? []),
      inconsistencies: List<String>.from(json['inconsistencies'] ?? []),
      origin: List<String>.from(json['origin'] ?? []),
      confidence: json['confidence'].toDouble(),
    );
  }
}