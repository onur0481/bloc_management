import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/bloc/cards_bloc.dart';
import '../../domain/bloc/cards_event.dart';
import '../../domain/bloc/cards_state.dart';

@RoutePage()
class CardEditPage extends StatelessWidget {
  final int cardId;

  const CardEditPage({
    super.key,
    @PathParam('cardId') required this.cardId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      builder: (context, state) {
        if (state is CardsLoaded) {
          final card = state.cards.firstWhere((c) => c.id == cardId);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Kart Düzenle'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: card.name,
                    decoration: const InputDecoration(
                      labelText: 'Kart Adı',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context.read<CardsBloc>().add(
                            UpdateCardName(
                              cardId: cardId,
                              newName: value,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: card.cardType,
                    decoration: const InputDecoration(
                      labelText: 'Kart Tipi',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'bank',
                        child: Text('Banka Kartı'),
                      ),
                      DropdownMenuItem(
                        value: 'credit',
                        child: Text('Kredi Kartı'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        context.read<CardsBloc>().add(
                              UpdateCardType(
                                cardId: cardId,
                                newType: value,
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    child: const Text('Kaydet'),
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
