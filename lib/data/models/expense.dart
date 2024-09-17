class Expense {
  final String id;
  final String summ;
  final String category;
  final String date;
  final String comment;

  Expense({
    required this.id,
    required this.category,
    required this.summ,
    required this.date,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'summ': summ,
      'category': category,
      'date': date,
      'comment': comment,
    };
  }

  static Expense fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      summ: map['summ'],
      category: map['category'],
      date: map['date'],
      comment: map['comment'],
    );
  }
}
