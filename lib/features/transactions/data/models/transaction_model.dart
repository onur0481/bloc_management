import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final int id;
  final int cardId;
  final String title;
  final double amount;
  final DateTime date;
  final String type; // 'income' veya 'expense'
  final String? description;
  final String? category;

  const TransactionModel({
    required this.id,
    required this.cardId,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    this.description,
    this.category,
  });

  @override
  List<Object?> get props => [
        id,
        cardId,
        title,
        amount,
        date,
        type,
        description,
        category,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardId': cardId,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type,
      'description': description,
      'category': category,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int,
      cardId: json['cardId'] as int,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
    );
  }
}
