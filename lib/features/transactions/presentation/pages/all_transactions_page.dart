import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/di/injection.dart';
import 'package:bloc_management/features/transactions/domain/bloc/transactions_bloc.dart';
import 'package:bloc_management/features/transactions/domain/bloc/transactions_event.dart';
import 'package:bloc_management/features/transactions/domain/bloc/transactions_state.dart';
import 'package:bloc_management/features/transactions/data/models/transaction_model.dart';

@RoutePage()
class AllTransactionsPage extends StatelessWidget {
  const AllTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<TransactionsBloc>()..add(const LoadTransactions(0)),
      child: const _AllTransactionsView(),
    );
  }
}

class _AllTransactionsView extends StatelessWidget {
  const _AllTransactionsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tüm İşlemler'),
      ),
      body: Column(
        children: [
          _buildFilterSection(context),
          Expanded(
            child: BlocBuilder<TransactionsBloc, TransactionsState>(
              builder: (context, state) {
                if (state is TransactionsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is TransactionsError) {
                  return Center(child: Text(state.message));
                }

                if (state is TransactionsLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<TransactionsBloc>().add(const RefreshTransactions(0));
                    },
                    child: _buildTransactionsList(context, state.transactions),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'İşlem Ara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<TransactionsBloc>().add(SearchTransactions(value));
              },
            ),
          ),
          const SizedBox(width: 16),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              context.read<TransactionsBloc>().add(FilterTransactions(value));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('Tümü'),
              ),
              const PopupMenuItem(
                value: 'income',
                child: Text('Gelirler'),
              ),
              const PopupMenuItem(
                value: 'expense',
                child: Text('Giderler'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(BuildContext context, List<TransactionModel> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text('İşlem bulunamadı'),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isIncome = transaction.type == 'income';

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isIncome ? Colors.green : Colors.red,
              child: Icon(
                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
            title: Text(transaction.title),
            subtitle: Text(
              '${transaction.date.toString().split(' ')[0]} - ${transaction.category ?? ''}',
            ),
            trailing: Text(
              '${isIncome ? '+' : '-'}${transaction.amount} TL',
              style: TextStyle(
                color: isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // İşlem detayı
            },
          ),
        );
      },
    );
  }
}
