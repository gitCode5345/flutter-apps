class Description {
  final int id;
  final String title;
  final String text;

  Description({
    required this.id,
    required this.title,
    required this.text,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
    };
  }

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
    );
  }
}
