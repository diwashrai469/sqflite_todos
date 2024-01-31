class TodoModel {
  final int id;
  final String description;
  final String title;
  final String date;
  final String priority;

  TodoModel(
    this.date,
    this.priority, {
    required this.id,
    required this.description,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'title': title,
      'date': date,
      'priority': priority,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      json['date'] as String,
      json['priority'] as String,
      id: json['id'] as int,
      description: json['description'] as String,
      title: json['title'] as String,
    );
  }
}
