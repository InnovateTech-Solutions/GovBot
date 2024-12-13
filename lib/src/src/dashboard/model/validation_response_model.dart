class ValidationResponse {
  final String result;
  final List<String> citations;
  final List<String> inconsistencies;
  final List<String> origin;
  final double confidence;

  ValidationResponse({
    required this.result,
    required this.citations,
    required this.inconsistencies,
    required this.origin,
    required this.confidence,
  });

  // Factory method to create a ValidationResponse from a JSON map
  factory ValidationResponse.fromJson(Map<String, dynamic> json) {
    return ValidationResponse(
      result: json['result'] as String,
      citations: List<String>.from(json['citations'] as List),
      inconsistencies: List<String>.from(json['inconsistencies'] as List),
      origin: List<String>.from(json['origin'] as List),
      confidence: json['confidence'] as double,
    );
  }

  String getFormattedResponse() {
    String formatted = "Result: $result\n";
    formatted += "Confidence: ${(confidence * 100).toStringAsFixed(2)}%\n";
    formatted += "\nInconsistencies:\n${inconsistencies.join("\n")}\n";
    formatted += "\nOrigin:\n${origin.join("\n")}\n";
    formatted += "\nCitations:\n${citations.join("\n")}\n";
    return formatted;
  }
}
