import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/features/cards/presentation/widgets/card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_event.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';

@RoutePage()
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      builder: (context, state) {
        if (state is CardsInitial) {
          context.read<CardsBloc>().add(LoadCards());
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CardsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CardsError) {
          return Center(child: Text(state.message));
        }

        if (state is CardsLoaded) {
          return Scaffold(
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
                _buildBalanceSummary(state),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cards.length,
                    itemBuilder: (context, index) {
                      final card = state.cards[index];

                      return CardItem(
                        card: card,
                        cardsBloc: context.read<CardsBloc>(),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBalanceSummary(CardsLoaded state) {
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
