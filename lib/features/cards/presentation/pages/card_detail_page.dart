import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/core/router/app_router.dart';
import 'package:bloc_management/core/widgets/base_bloc_builder.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';

@RoutePage()
class CardDetailPage extends StatelessWidget {
  final int cardId;

  const CardDetailPage({
    super.key,
    @PathParam('cardId') required this.cardId,
  });

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<CardsBloc, CardsState, List<CardModel>>(
      bloc: context.read<CardsBloc>(),
      stateSelector: (state) => state.cardsState,
      onLoaded: (cards) {
        final card = cards.firstWhere((c) => c.id == cardId);
        final balance = context.read<CardsBloc>().state.cardBalances[cardId];

        return Scaffold(
          appBar: AppBar(
            title: Text(card.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.router.push(
                  CardEditRoute(cardId: cardId),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => context.router.push(
                  CardSettingsRoute(cardId: cardId),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildCardHeader(card, balance),
                const SizedBox(height: 16),
                _buildActionButtons(context),
                const SizedBox(height: 16),
                _buildTransactionsList(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardHeader(CardModel card, num? balance) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                card.cardType == 'bank' ? Icons.account_balance : Icons.credit_card,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                card.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bakiye: ${balance ?? "Yükleniyor..."} TL',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            context,
            'İşlemler',
            Icons.history,
            () => context.router.push(
              TransactionsRoute(cardId: cardId),
            ),
          ),
          _buildActionButton(
            context,
            'Paylaş',
            Icons.share,
            () {
              // Paylaşım işlemi
            },
          ),
          _buildActionButton(
            context,
            'Ayarlar',
            Icons.settings,
            () => context.router.push(
              CardSettingsRoute(cardId: cardId),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Son İşlemler',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5, // Örnek veri
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.shopping_cart),
                ),
                title: Text('İşlem ${index + 1}'),
                subtitle: Text('${DateTime.now().subtract(Duration(days: index))}'),
                trailing: Text('${(index + 1) * 100} TL'),
              );
            },
          ),
        ],
      ),
    );
  }
}
