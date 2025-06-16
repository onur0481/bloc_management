import 'package:bloc_management/core/base/base_state.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';

class CardsState extends BaseState<List<CardModel>> {
  final num totalBankBalance;
  final num totalBrandBalance;
  final Map<int, num?> cardBalances;

  const CardsState({
    super.data,
    super.message,
    super.isLoading = false,
    this.totalBankBalance = 0,
    this.totalBrandBalance = 0,
    this.cardBalances = const {},
  });

  factory CardsState.initial() => const CardsState();
  factory CardsState.loading() => const CardsState(isLoading: true);
  factory CardsState.error(String message) => CardsState(message: message);
  factory CardsState.loaded({
    required List<CardModel> cards,
    required num totalBankBalance,
    required num totalBrandBalance,
    required Map<int, num?> cardBalances,
  }) =>
      CardsState(
        data: cards,
        totalBankBalance: totalBankBalance,
        totalBrandBalance: totalBrandBalance,
        cardBalances: cardBalances,
      );

  @override
  List<Object?> get props => [data, message, isLoading, totalBankBalance, totalBrandBalance, cardBalances];

  CardsState copyWith({
    List<CardModel>? data,
    String? message,
    bool? isLoading,
    num? totalBankBalance,
    num? totalBrandBalance,
    Map<int, num?>? cardBalances,
  }) {
    return CardsState(
      data: data ?? this.data,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      totalBankBalance: totalBankBalance ?? this.totalBankBalance,
      totalBrandBalance: totalBrandBalance ?? this.totalBrandBalance,
      cardBalances: cardBalances ?? this.cardBalances,
    );
  }
}
