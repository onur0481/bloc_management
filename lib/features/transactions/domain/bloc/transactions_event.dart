import 'package:equatable/equatable.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionsEvent {
  final int cardId;

  const LoadTransactions(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

class RefreshTransactions extends TransactionsEvent {
  final int cardId;

  const RefreshTransactions(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

class SearchTransactions extends TransactionsEvent {
  final String query;

  const SearchTransactions(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterTransactions extends TransactionsEvent {
  final String filter;

  const FilterTransactions(this.filter);

  @override
  List<Object?> get props => [filter];
}
