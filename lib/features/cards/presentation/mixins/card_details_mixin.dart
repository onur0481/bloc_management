import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';

mixin CardDetailsMixin {
  void showCardDetails(BuildContext context, CardModel card) {
    final cardsBloc = context.read<CardsBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cardsBloc,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Color(int.parse(card.cardColor.replaceAll('#', '0xFF'))),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: 16,
                                top: 16,
                                child: Image.asset(
                                  card.cardLogo,
                                  width: 60,
                                  height: 60,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    Icons.credit_card,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                bottom: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      card.cardNumber,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      card.cardHolderName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildDetailItem('Kart Adı', card.name),
                      _buildDetailItem('Kart Numarası', card.cardNumber),
                      _buildDetailItem('Son Kullanma Tarihi', card.expiryDate),
                      _buildDetailItem('CVV', card.cvv),
                      _buildDetailItem('Kart Sahibi', card.cardHolderName),
                      _buildDetailItem('Banka', card.cardType),
                      _buildDetailItem('Kart Tipi', card.cardType == 'bank' ? 'Banka Kartı' : 'Marka Kartı'),
                      BlocBuilder<CardsBloc, CardsState>(
                        builder: (context, state) {
                          if (state.data != null) {
                            final balance = state.cardBalances[card.id];
                            return _buildDetailItem('Bakiye', '${balance?.toString() ?? 'Yükleniyor...'} TL');
                          }
                          return _buildDetailItem('Bakiye', 'Yükleniyor...');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
