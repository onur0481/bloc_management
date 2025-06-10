import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/features/cards/presentation/pages/card_detail_page.dart';
import 'package:bloc_management/features/cards/presentation/pages/card_settings_page.dart';
import 'package:bloc_management/features/cards/presentation/pages/cards_page.dart';
import 'package:bloc_management/features/cards/presentation/pages/card_edit_page.dart';
import 'package:bloc_management/features/home/presentation/pages/home_page.dart';
import 'package:bloc_management/features/transactions/presentation/pages/all_transactions_page.dart';
import 'package:bloc_management/features/transactions/presentation/pages/transactions_page.dart';
import 'package:bloc_management/features/form_management/presentation/pages/form_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(
              path: 'cards',
              page: CardsRoute.page,
            ),
            AutoRoute(
              path: 'transactions',
              page: AllTransactionsRoute.page,
            ),
            AutoRoute(
              path: 'form',
              page: FormRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/cards/:cardId',
          page: CardDetailRoute.page,
        ),
        AutoRoute(
          path: '/cards/:cardId/settings',
          page: CardSettingsRoute.page,
        ),
        AutoRoute(
          path: '/cards/:cardId/edit',
          page: CardEditRoute.page,
        ),
        AutoRoute(
          path: '/cards/:cardId/transactions',
          page: TransactionsRoute.page,
        ),
      ];
}
