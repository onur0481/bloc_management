import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_management/core/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/base/handle_api_call_mixin.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';
import 'package:bloc_management/features/cards/data/repositories/card_repository.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_event.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> with HandleApiCallMixin {
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
    print('[CardsBloc] LoadCards event triggered');
    await handleApiCall<List<CardModel>>(
      apiCall: _cardRepository.getAllCards,
      emitState: (state) {
        print('[CardsBloc] handleApiCall emitState: ' + state.toString());
        if (state is LoadedState<List<CardModel>>) {
          _allCards = state.data ?? [];

          final Map<int, num?> cardBalances = {};
          num totalBankBalance = 0;
          num totalBrandBalance = 0;

          emit(CardsState(
            cardsState: state,
            cardBalances: cardBalances,
            totalBankBalance: totalBankBalance,
            totalBrandBalance: totalBrandBalance,
          ));

          for (final card in _allCards) {
            add(LoadCardBalance(card.id));
          }
        } else {
          emit(CardsState(
            cardsState: state,
            cardBalances: this.state.cardBalances,
            totalBankBalance: this.state.totalBankBalance,
            totalBrandBalance: this.state.totalBrandBalance,
          ));
        }
      },
    );
  }

  Future<void> _onLoadCardBalance(LoadCardBalance event, Emitter<CardsState> emit) async {
    await handleApiCall<num>(
      apiCall: () => _cardRepository.getCardBalance(event.cardId),
      emitState: (state) {
        if (state is LoadedState<num>) {
          final balance = state.data;

          final updatedBalances = Map<int, num?>.from(this.state.cardBalances);
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

          emit(this.state.copyWith(
                cardBalances: updatedBalances,
                totalBankBalance: totalBankBalance,
                totalBrandBalance: totalBrandBalance,
              ));
        }
      },
    );
  }

  void _onFilterCards(FilterCards event, Emitter<CardsState> emit) {
    if (event.cardType == 'all') {
      emit(state.copyWith(cardsState: LoadedState<List<CardModel>>(_allCards)));
    } else {
      final filteredCards = _allCards.where((card) => card.cardType == event.cardType).toList();
      emit(state.copyWith(cardsState: LoadedState<List<CardModel>>(filteredCards)));
    }
  }

  Future<void> _onDeleteCard(DeleteCard event, Emitter<CardsState> emit) async {
    await handleVoidApiCall(
      apiCall: () => _cardRepository.deleteCard(event.cardId),
      emitState: (state) {
        emit(this.state.copyWith(cardsState: LoadingState<List<CardModel>>()));
      },
      onSuccess: () {
        add(LoadCards());
      },
      onError: (msg) {
        emit(state.copyWith(
          cardsState: ErrorState<List<CardModel>>(msg ?? 'Kart silinemedi'),
        ));
      },
    );
  }

  Future<void> _onRefreshTransactions(RefreshTransactions event, Emitter<CardsState> emit) async {
    await handleApiCall<num>(
      apiCall: () => _cardRepository.getCardBalance(event.cardId),
      emitState: (state) {
        if (state is LoadedState<num>) {
          final balance = state.data;

          final updatedBalances = Map<int, num?>.from(this.state.cardBalances);
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

          emit(this.state.copyWith(
                cardBalances: updatedBalances,
                totalBankBalance: totalBankBalance,
                totalBrandBalance: totalBrandBalance,
              ));
        }
      },
    );
  }

  void _onUpdateCardName(UpdateCardName event, Emitter<CardsState> emit) {
    if (state.cardsState is LoadedState<List<CardModel>>) {
      final currentCards = (state.cardsState as LoadedState<List<CardModel>>).data ?? [];
      final updatedCards = currentCards.map((card) {
        if (card.id == event.cardId) {
          return card.copyWith(name: event.newName);
        }
        return card;
      }).toList();
      _allCards = updatedCards;
      emit(state.copyWith(cardsState: LoadedState<List<CardModel>>(updatedCards)));
    }
  }

  void _onUpdateCardType(UpdateCardType event, Emitter<CardsState> emit) {
    if (state.cardsState is LoadedState<List<CardModel>>) {
      final currentCards = (state.cardsState as LoadedState<List<CardModel>>).data ?? [];
      final updatedCards = currentCards.map((card) {
        if (card.id == event.cardId) {
          return card.copyWith(cardType: event.newType);
        }
        return card;
      }).toList();
      _allCards = updatedCards;
      emit(state.copyWith(cardsState: LoadedState<List<CardModel>>(updatedCards)));
    }
  }
}
