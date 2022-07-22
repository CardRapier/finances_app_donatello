import 'dart:convert';

List<Expense> expenseFromJson(String str) =>
    List<Expense>.from(json.decode(str).map((x) => Expense.fromJson(x)));

String expenseToJson(List<Expense> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Expense {
  Expense({
    required this.isExpense,
    this.description,
    required this.date,
    required this.type,
    required this.value,
  });

  bool isExpense;
  String? description;
  DateTime date;
  String type;
  int value;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        isExpense: json["isExpense"],
        description: json["description"],
        date: json["date"].toDate(),
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "isExpense": isExpense,
        "description": description,
        "date": date,
        "type": type,
        "value": value,
      };
}
