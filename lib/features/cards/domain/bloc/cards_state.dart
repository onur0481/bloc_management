import 'package:bloc_management/core/base/base_state.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';

class CardsState {
  final BaseState<List<CardModel>> cardsState;
  final Map<int, num?> cardBalances;
  final num totalBankBalance;
  final num totalBrandBalance;

  const CardsState({
    required this.cardsState,
    this.cardBalances = const {},
    this.totalBankBalance = 0,
    this.totalBrandBalance = 0,
  });

  factory CardsState.initial() => const CardsState(cardsState: LoadingState());

  CardsState copyWith({
    BaseState<List<CardModel>>? cardsState,
    Map<int, num?>? cardBalances,
    num? totalBankBalance,
    num? totalBrandBalance,
  }) {
    return CardsState(
      cardsState: cardsState ?? this.cardsState,
      cardBalances: cardBalances ?? this.cardBalances,
      totalBankBalance: totalBankBalance ?? this.totalBankBalance,
      totalBrandBalance: totalBrandBalance ?? this.totalBrandBalance,
    );
  }
}
