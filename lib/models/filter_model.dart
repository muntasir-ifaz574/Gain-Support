class FilterField {
  final String type;
  final String label;
  final List<String>? options;

  FilterField({required this.type, required this.label, this.options});

  factory FilterField.fromJson(Map<String, dynamic> json) {
    return FilterField(
      type: json['type'],
      label: json['label'],
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : null,
    );
  }
}
