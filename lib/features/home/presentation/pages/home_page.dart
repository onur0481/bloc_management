import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/features/transactions/presentation/pages/all_transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/home/domain/bloc/home_bloc.dart';
import 'package:bloc_management/features/home/domain/bloc/home_state.dart';
import 'package:bloc_management/features/home/domain/bloc/home_event.dart';
import 'package:bloc_management/features/cards/presentation/pages/cards_page.dart';
import 'package:bloc_management/features/transactions/domain/bloc/transactions_bloc.dart';
import 'package:bloc_management/features/transactions/domain/bloc/transactions_event.dart';
import 'package:bloc_management/features/form_management/presentation/bloc/form_bloc.dart';
import 'package:bloc_management/features/form_management/presentation/pages/form_page.dart';
import 'package:bloc_management/core/di/injection.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const CardsPage();
      case 1:
        return BlocProvider(
          create: (context) => getIt<TransactionsBloc>()..add(const LoadTransactions(0)),
          child: const AllTransactionsPage(),
        );
      case 2:
        return BlocProvider(
          create: (context) => getIt<FormBloc>(),
          child: const FormPage(),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedTab,
            children: [
              _buildPage(0),
              _buildPage(1),
              _buildPage(2),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.selectedTab,
            onDestinationSelected: (index) {
              context.read<HomeBloc>().add(TabChanged(index));
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.credit_card_outlined),
                selectedIcon: Icon(Icons.credit_card),
                label: 'Kartlar',
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long),
                label: 'İşlemler',
              ),
              NavigationDestination(
                icon: Icon(Icons.edit_note_outlined),
                selectedIcon: Icon(Icons.edit_note),
                label: 'Form',
              ),
            ],
          ),
        );
      },
    );
  }
}
