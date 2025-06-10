import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/base/base_bloc.dart';
import 'package:bloc_management/core/error/app_error.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';
import 'package:bloc_management/features/cards/data/repositories/card_repository.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_event.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';

class CardsBloc extends BaseBloc<CardsEvent, CardsState> {
  final CardRepository _cardRepository;
  List<CardModel> _allCards = [];

  CardsBloc(this._cardRepository) : super(CardsInitial()) {
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
      await handleLoading(emit, (isLoading) => CardsLoading());
      _allCards = await _cardRepository.getAll();

      final Map<int, num?> cardBalances = {};
      num totalBankBalance = 0;
      num totalBrandBalance = 0;

      await handleSuccess(
        _allCards,
        emit,
        (cards) => CardsLoaded(
          cards: cards,
          totalBankBalance: totalBankBalance,
          totalBrandBalance: totalBrandBalance,
          cardBalances: cardBalances,
        ),
      );

      for (final card in _allCards) {
        add(LoadCardBalance(card.id));
      }
    } catch (e) {
      await handleError(
        AppError(message: e.toString()),
        emit,
        (error) => CardsError(error),
      );
    }
  }

  Future<void> _onLoadCardBalance(LoadCardBalance event, Emitter<CardsState> emit) async {
    if (state is CardsLoaded) {
      final currentState = state as CardsLoaded;
      try {
        final balance = await _cardRepository.getCardBalance(event.cardId);

        final updatedBalances = Map<int, num?>.from(currentState.cardBalances);
        updatedBalances[event.cardId] = balance;

        num totalBankBalance = 0;
        num totalBrandBalance = 0;

        // Sadece ekranda görünen kartlar üzerinden toplamları hesapla
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
        print('Kart ID: ${event.cardId}, Bakiye: $balance');

        emit(currentState.copyWith(
          cards: List<CardModel>.from(currentState.cards),
          cardBalances: updatedBalances,
          totalBankBalance: totalBankBalance,
          totalBrandBalance: totalBrandBalance,
        ));
      } catch (e) {
        emit(CardsError(e.toString()));
      }
    }
  }

  void _onFilterCards(FilterCards event, Emitter<CardsState> emit) {
    if (state is CardsLoaded) {
      final currentState = state as CardsLoaded;
      if (event.cardType == 'all') {
        final filteredCards = _allCards;
        emit(currentState.copyWith(cards: filteredCards));
      } else {
        final filteredCards = _allCards.where((card) => card.cardType == event.cardType).toList();
        emit(currentState.copyWith(cards: filteredCards));
      }
    }
  }

  Future<void> _onDeleteCard(
    DeleteCard event,
    Emitter<CardsState> emit,
  ) async {
    try {
      await _cardRepository.delete(event.cardId);
      _allCards.removeWhere((card) => card.id == event.cardId);
      emit(CardsLoaded(
        cards: _allCards,
        totalBankBalance: state is CardsLoaded ? (state as CardsLoaded).totalBankBalance : 0,
        totalBrandBalance: state is CardsLoaded ? (state as CardsLoaded).totalBrandBalance : 0,
        cardBalances: state is CardsLoaded ? (state as CardsLoaded).cardBalances : {},
      ));
    } catch (e) {
      await handleError(
        AppError(message: e.toString()),
        emit,
        (error) => CardsError(error),
      );
    }
  }

  Future<void> _onRefreshTransactions(RefreshTransactions event, Emitter<CardsState> emit) async {
    if (state is CardsLoaded) {
      try {
        // Kart bakiyesini yenile
        final balance = await _cardRepository.getCardBalance(event.cardId);

        final currentState = state as CardsLoaded;
        final updatedBalances = Map<int, num?>.from(currentState.cardBalances);
        updatedBalances[event.cardId] = balance;

        // Toplam bakiyeleri güncelle
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

        emit(currentState.copyWith(
          cards: List<CardModel>.from(currentState.cards),
          cardBalances: updatedBalances,
          totalBankBalance: totalBankBalance,
          totalBrandBalance: totalBrandBalance,
        ));
      } catch (e) {
        emit(CardsError(e.toString()));
      }
    }
  }

  void _onUpdateCardName(
    UpdateCardName event,
    Emitter<CardsState> emit,
  ) {
    if (state is CardsLoaded) {
      final currentState = state as CardsLoaded;
      final updatedCards = currentState.cards.map((card) {
        if (card.id == event.cardId) {
          return card.copyWith(name: event.newName);
        }
        return card;
      }).toList();

      emit(currentState.copyWith(cards: updatedCards));
    }
  }

  void _onUpdateCardType(
    UpdateCardType event,
    Emitter<CardsState> emit,
  ) {
    if (state is CardsLoaded) {
      final currentState = state as CardsLoaded;
      final updatedCards = currentState.cards.map((card) {
        if (card.id == event.cardId) {
          return card.copyWith(cardType: event.newType);
        }
        return card;
      }).toList();

      emit(currentState.copyWith(cards: updatedCards));
    }
  }
}
