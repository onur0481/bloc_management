import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/core/router/app_router.dart';

class CardItem extends StatelessWidget {
  final CardModel card;
  final CardsBloc cardsBloc;

  const CardItem({
    super.key,
    required this.card,
    required this.cardsBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CardsBloc, CardsState, num?>(
      selector: (state) {
        return state.cardBalances[card.id];
      },
      builder: (context, balance) {
        return GestureDetector(
          onTap: () => context.router.push(CardDetailRoute(cardId: card.id)),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BlocProvider.value(
              value: cardsBloc,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(int.parse(card.cardColor.replaceAll('#', '0xFF'))),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            card.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            card.cardLogo,
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.credit_card,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        card.cardNumber,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<CardsBloc, CardsState>(
                        builder: (context, state) {
                          final balance = state.cardBalances[card.id];
                          return Text(
                            'Bakiye: ${balance?.toString() ?? 'Yükleniyor...'} TL',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
