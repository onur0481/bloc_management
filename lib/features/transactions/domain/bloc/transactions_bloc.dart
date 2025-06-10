import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/base/base_bloc.dart';
import 'package:bloc_management/core/error/app_error.dart';
import 'package:bloc_management/features/transactions/data/models/transaction_model.dart';
import 'package:bloc_management/features/transactions/data/repositories/transaction_repository.dart';
import 'package:bloc_management/features/transactions/domain/bloc/transactions_event.dart';
import 'package:bloc_management/features/transactions/domain/bloc/transactions_state.dart';

class TransactionsBloc extends BaseBloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository _repository;
  List<TransactionModel> _originalTransactions = [];
  String _currentFilter = 'all';
  String _currentQuery = '';

  TransactionsBloc(this._repository) : super(const TransactionsInitial()) {
    on<LoadTransactions>(_onLoadTransactions, transformer: restartable());
    on<RefreshTransactions>(_onRefreshTransactions, transformer: restartable());
    on<SearchTransactions>(_onSearchTransactions, transformer: droppable());
    on<FilterTransactions>(_onFilterTransactions, transformer: droppable());
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      await handleLoading(emit, (isLoading) => const TransactionsLoading());
      final transactions = await _repository.getTransactions(event.cardId);
      _originalTransactions = transactions;
      await handleSuccess(
        transactions,
        emit,
        (data) => TransactionsLoaded(transactions: data),
      );
    } catch (e) {
      await handleError(
        AppError(message: e.toString()),
        emit,
        (error) => TransactionsError(error),
      );
    }
  }

  Future<void> _onRefreshTransactions(
    RefreshTransactions event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      final transactions = await _repository.getTransactions(event.cardId);
      _originalTransactions = transactions;
      await handleSuccess(
        transactions,
        emit,
        (data) => TransactionsLoaded(transactions: data),
      );
    } catch (e) {
      await handleError(
        AppError(message: e.toString()),
        emit,
        (error) => TransactionsError(error),
      );
    }
  }

  void _onSearchTransactions(
    SearchTransactions event,
    Emitter<TransactionsState> emit,
  ) {
    _currentQuery = event.query.toLowerCase();
    _applyFilters(emit);
  }

  void _onFilterTransactions(
    FilterTransactions event,
    Emitter<TransactionsState> emit,
  ) {
    _currentFilter = event.filter;
    _applyFilters(emit);
  }

  void _applyFilters(Emitter<TransactionsState> emit) {
    var filteredTransactions = _originalTransactions;

    if (_currentQuery.isNotEmpty) {
      filteredTransactions = filteredTransactions.where((transaction) {
        final title = transaction.title.toLowerCase();
        final description = transaction.description?.toLowerCase() ?? '';
        final amount = transaction.amount.toString();
        return title.contains(_currentQuery) || description.contains(_currentQuery) || amount.contains(_currentQuery);
      }).toList();
    }

    if (_currentFilter != 'all') {
      filteredTransactions = filteredTransactions.where((transaction) {
        return transaction.type == _currentFilter;
      }).toList();
    }

    emit(TransactionsLoaded(transactions: filteredTransactions));
  }
}
