import 'package:bloc_management/core/base/base_state.dart';
import 'package:bloc_management/features/transactions/data/models/transaction_model.dart';

abstract class TransactionsState extends BaseState<List<TransactionModel>> {
  const TransactionsState({
    super.data,
    super.error,
    super.isLoading = false,
  });
}

class TransactionsInitial extends TransactionsState {
  const TransactionsInitial() : super();
}

class TransactionsLoading extends TransactionsState {
  const TransactionsLoading() : super(isLoading: true);
}

class TransactionsLoaded extends TransactionsState {
  final List<TransactionModel> transactions;

  const TransactionsLoaded({
    required this.transactions,
  }) : super(data: transactions);

  @override
  List<Object?> get props => [transactions];
}

class TransactionsError extends TransactionsState {
  final String message;

  const TransactionsError(this.message) : super(error: message);

  @override
  List<Object?> get props => [message];
}
