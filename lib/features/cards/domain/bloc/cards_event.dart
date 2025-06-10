import 'package:equatable/equatable.dart';

abstract class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCards extends CardsEvent {}

class LoadCardBalance extends CardsEvent {
  final int cardId;

  const LoadCardBalance(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

class FilterCards extends CardsEvent {
  final String cardType;

  const FilterCards(this.cardType);

  @override
  List<Object?> get props => [cardType];
}

class DeleteCard extends CardsEvent {
  final int cardId;

  const DeleteCard(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

class RefreshTransactions extends CardsEvent {
  final int cardId;

  const RefreshTransactions(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

class UpdateCardName extends CardsEvent {
  final int cardId;
  final String newName;

  const UpdateCardName({
    required this.cardId,
    required this.newName,
  });

  @override
  List<Object> get props => [cardId, newName];
}

class UpdateCardType extends CardsEvent {
  final int cardId;
  final String newType;

  const UpdateCardType({
    required this.cardId,
    required this.newType,
  });

  @override
  List<Object> get props => [cardId, newType];
}
