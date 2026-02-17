class Ticket {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime date;
  final String senderName;
  final String priority;
  final List<String> tags;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.senderName,
    required this.priority,
    required this.tags,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      senderName: json['senderName'],
      priority: json['priority'],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}
