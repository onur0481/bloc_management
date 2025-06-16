import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/base/base_bloc.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';
import 'package:bloc_management/features/cards/data/repositories/card_repository.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_event.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';

class CardsBloc extends BaseBloc<CardsEvent, CardsState> {
  final CardRepository _cardRepository;
  List<CardModel> _allCards = [];

  CardsBloc(this._cardRepository) : super(CardsState.initial()) {
    on<LoadCards>(_onLoadCards, transformer: concurrent());
    on<LoadCardBalance>(_onLoadCardBalance, transformer: sequential());
    on<FilterCards>(_onFilterCards, transformer: droppable());
    on<DeleteCard>(_onDeleteCard);
    on<RefreshTransactions>(_onRefreshTransactions, transformer: restartable());
    on<UpdateCardName>(_onUpdateCardName);
    on<UpdateCardType>(_onUpdateCardType);
  }

  Future<void> _onLoadCards(LoadCards event, Emitter<CardsState> emit) async {
    try {
      emit(CardsState.loading());
      _allCards = await _cardRepository.getAll();

      final Map<int, num?> cardBalances = {};
      num totalBankBalance = 0;
      num totalBrandBalance = 0;

      emit(CardsState.loaded(
        cards: _allCards,
        totalBankBalance: totalBankBalance,
        totalBrandBalance: totalBrandBalance,
        cardBalances: cardBalances,
      ));

      for (final card in _allCards) {
        add(LoadCardBalance(card.id));
      }
    } catch (e) {
      emit(CardsState.error(e.toString()));
    }
  }

  Future<void> _onLoadCardBalance(LoadCardBalance event, Emitter<CardsState> emit) async {
    if (state.data != null) {
      try {
        final balance = await _cardRepository.getCardBalance(event.cardId);

        final updatedBalances = Map<int, num?>.from(state.cardBalances);
        updatedBalances[event.cardId] = balance;

        num totalBankBalance = 0;
        num totalBrandBalance = 0;

        for (final c in _allCards) {
          final b = updatedBalances[c.id];
          if (b != null) {
            if (c.cardType == 'bank') {
              totalBankBalance += b;
            } else {
              totalBrandBalance += b;
            }
          }
        }

        emit(state.copyWith(
          cardBalances: updatedBalances,
          totalBankBalance: totalBankBalance,
          totalBrandBalance: totalBrandBalance,
        ));
      } catch (e) {
        emit(CardsState.error(e.toString()));
      }
    }
  }

  void _onFilterCards(FilterCards event, Emitter<CardsState> emit) {
    if (state.data != null) {
      if (event.cardType == 'all') {
        emit(state.copyWith(data: _allCards));
      } else {
        final filteredCards = _allCards.where((card) => card.cardType == event.cardType).toList();
        emit(state.copyWith(data: filteredCards));
      }
    }
  }

  Future<void> _onDeleteCard(DeleteCard event, Emitter<CardsState> emit) async {
    try {
      await _cardRepository.delete(event.cardId);
      _allCards.removeWhere((card) => card.id == event.cardId);
      emit(CardsState.loaded(
        cards: _allCards,
        totalBankBalance: state.totalBankBalance,
        totalBrandBalance: state.totalBrandBalance,
        cardBalances: state.cardBalances,
      ));
    } catch (e) {
      emit(CardsState.error(e.toString()));
    }
  }

  Future<void> _onRefreshTransactions(RefreshTransactions event, Emitter<CardsState> emit) async {
    if (state.data != null) {
      try {
        final balance = await _cardRepository.getCardBalance(event.cardId);

        final updatedBalances = Map<int, num?>.from(state.cardBalances);
        updatedBalances[event.cardId] = balance;

        num totalBankBalance = 0;
        num totalBrandBalance = 0;

        for (final card in _allCards) {
          final b = updatedBalances[card.id];
          if (b != null) {
            if (card.cardType == 'bank') {
              totalBankBalance += b;
            } else {
              totalBrandBalance += b;
            }
          }
        }

        emit(state.copyWith(
          cardBalances: updatedBalances,
          totalBankBalance: totalBankBalance,
          totalBrandBalance: totalBrandBalance,
        ));
      } catch (e) {
        emit(CardsState.error(e.toString()));
      }
    }
  }

  void _onUpdateCardName(UpdateCardName event, Emitter<CardsState> emit) {
    if (state.data != null) {
      final updatedCards = state.data!.map((card) {
        if (card.id == event.cardId) {
          return card.copyWith(name: event.newName);
        }
        return card;
      }).toList();

      emit(state.copyWith(data: updatedCards));
    }
  }

  void _onUpdateCardType(UpdateCardType event, Emitter<CardsState> emit) {
    if (state.data != null) {
      final updatedCards = state.data!.map((card) {
        if (card.id == event.cardId) {
          return card.copyWith(cardType: event.newType);
        }
        return card;
      }).toList();

      emit(state.copyWith(data: updatedCards));
    }
  }
}
