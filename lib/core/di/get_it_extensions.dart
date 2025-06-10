import 'package:bloc_management/features/home/domain/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:bloc_management/features/cards/data/repositories/card_repository.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_bloc.dart';
import 'package:bloc_management/features/transactions/data/repositories/transaction_repository.dart';
import 'package:bloc_management/features/transactions/domain/bloc/transactions_bloc.dart';

extension BlocRegistration on GetIt {
  void registerBlocs() {
    registerLazySingleton<CardsBloc>(
      () => CardsBloc(get<CardRepository>()),
    );
    registerLazySingleton<TransactionsBloc>(
      () => TransactionsBloc(get<TransactionRepository>()),
    );
  }

  void registerRepositories() {
    registerLazySingleton<CardRepository>(
      () => CardRepository(),
    );
    registerLazySingleton<TransactionRepository>(
      () => TransactionRepository(),
    );
  }

  void registerHomeBloc() {
    registerLazySingleton<HomeBloc>(
      () => HomeBloc(),
    );
  }
}
