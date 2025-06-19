import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_event.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';
import 'package:bloc_management/features/cards/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/widgets/base_bloc_consumer.dart';
import 'package:bloc_management/core/widgets/base_bloc_builder.dart';

@RoutePage()
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartlarım'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const CardFilterBottomSheet(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BaseBlocBuilder<CardsBloc, CardsState, List<CardModel>>(
            bloc: context.read<CardsBloc>(),
            stateSelector: (state) => state.cardsState,
            onLoaded: (_) => _buildBalanceSummary(
              context.read<CardsBloc>().state.totalBankBalance,
              context.read<CardsBloc>().state.totalBrandBalance,
            ),
            onLoading: _buildLoadingBalanceSummary(),
            onNoContent: _buildBalanceSummary(0, 0),
          ),
          Expanded(
            child: BaseBlocConsumer<CardsBloc, CardsState, List<CardModel>>(
              bloc: context.read<CardsBloc>(),
              stateSelector: (state) => state.cardsState,
              onLoaded: (cards) {
                if (cards.isEmpty) {
                  return const Center(child: Text('Kart bulunamadı'));
                }
                return ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return CardItem(
                      card: card,
                      cardsBloc: context.read<CardsBloc>(),
                    );
                  },
                );
              },
              onNoContent: const Center(child: Text('Kart bulunamadı')),
              onLoading: const Center(child: CircularProgressIndicator()),
              onStateChange: (context, baseState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kart silindi!')),
                );
              },
              listenWhen: (previous, current) => current is CardDeletedState,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingBalanceSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBalanceCard(
            'Banka Bakiyesi',
            'Yükleniyor...',
            Icons.account_balance,
          ),
          _buildBalanceCard(
            'Marka Bakiyesi',
            'Yükleniyor...',
            Icons.shopping_bag,
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSummary(num totalBank, num totalBrand) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBalanceCard(
            'Banka Bakiyesi',
            totalBank.toString(),
            Icons.account_balance,
          ),
          _buildBalanceCard(
            'Marka Bakiyesi',
            totalBrand.toString(),
            Icons.shopping_bag,
          ),
        ],
      ),
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
