import 'package:bloc_management/core/base/base_state.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';

abstract class CardsState extends BaseState<List<CardModel>> {
  const CardsState({
    super.data,
    super.error,
    super.isLoading = false,
  });
}

class CardsInitial extends CardsState {
  const CardsInitial() : super();
}

class CardsLoading extends CardsState {
  const CardsLoading() : super(isLoading: true);
}

class CardsLoaded extends CardsState {
  final List<CardModel> cards;
  final num totalBankBalance;
  final num totalBrandBalance;
  final Map<int, num?> cardBalances;

  const CardsLoaded({
    required this.cards,
    required this.totalBankBalance,
    required this.totalBrandBalance,
    required this.cardBalances,
    bool isLoading = false,
  }) : super(
          data: cards,
          isLoading: isLoading,
        );

  @override
  List<Object?> get props => [cards, totalBankBalance, totalBrandBalance, cardBalances, isLoading];

  CardsLoaded copyWith({
    List<CardModel>? cards,
    num? totalBankBalance,
    num? totalBrandBalance,
    Map<int, num?>? cardBalances,
    bool? isLoading,
  }) {
    return CardsLoaded(
      cards: cards ?? this.cards,
      totalBankBalance: totalBankBalance ?? this.totalBankBalance,
      totalBrandBalance: totalBrandBalance ?? this.totalBrandBalance,
      cardBalances: cardBalances ?? this.cardBalances,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CardsError extends CardsState {
  final String message;

  const CardsError(this.message) : super(error: message);

  @override
  List<Object?> get props => [message];
}
