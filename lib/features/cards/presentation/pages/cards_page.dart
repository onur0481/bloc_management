import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/core/widgets/base_bloc_builder.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_event.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';
import 'package:bloc_management/features/cards/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<CardsBloc, CardsState, List<CardModel>>(
      bloc: context.read<CardsBloc>(),
      stateSelector: (state) => state.cardsState,
      onLoaded: (cards) => Scaffold(
        appBar: AppBar(
          title: const Text('Kartlarım'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => CardFilterBottomSheet(),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildBalanceSummary(context),
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return CardItem(
                    card: card,
                    cardsBloc: context.read<CardsBloc>(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceSummary(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      buildWhen: (previous, current) => previous.totalBankBalance != current.totalBankBalance || previous.totalBrandBalance != current.totalBrandBalance,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBalanceCard(
                'Banka Bakiyesi',
                state.totalBankBalance.toString(),
                Icons.account_balance,
              ),
              _buildBalanceCard(
                'Marka Bakiyesi',
                state.totalBrandBalance.toString(),
                Icons.shopping_bag,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBalanceCard(String title, String amount, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardFilterBottomSheet extends StatelessWidget {
  const CardFilterBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Tüm Kartlar'),
            onTap: () {
              context.read<CardsBloc>().add(const FilterCards('all'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Banka Kartları'),
            onTap: () {
              context.read<CardsBloc>().add(const FilterCards('bank'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Marka Kartları'),
            onTap: () {
              context.read<CardsBloc>().add(const FilterCards('brand'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
