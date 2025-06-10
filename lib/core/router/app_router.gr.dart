// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AllTransactionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AllTransactionsPage(),
      );
    },
    CardDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CardDetailRouteArgs>(
          orElse: () =>
              CardDetailRouteArgs(cardId: pathParams.getInt('cardId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CardDetailPage(
          key: args.key,
          cardId: args.cardId,
        ),
      );
    },
    CardEditRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CardEditRouteArgs>(
          orElse: () => CardEditRouteArgs(cardId: pathParams.getInt('cardId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CardEditPage(
          key: args.key,
          cardId: args.cardId,
        ),
      );
    },
    CardSettingsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CardSettingsRouteArgs>(
          orElse: () =>
              CardSettingsRouteArgs(cardId: pathParams.getInt('cardId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CardSettingsPage(
          key: args.key,
          cardId: args.cardId,
        ),
      );
    },
    CardsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CardsPage(),
      );
    },
    FormRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FormPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    TransactionsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TransactionsRouteArgs>(
          orElse: () =>
              TransactionsRouteArgs(cardId: pathParams.getInt('cardId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransactionsPage(
          key: args.key,
          cardId: args.cardId,
        ),
      );
    },
  };
}

/// generated route for
/// [AllTransactionsPage]
class AllTransactionsRoute extends PageRouteInfo<void> {
  const AllTransactionsRoute({List<PageRouteInfo>? children})
      : super(
          AllTransactionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllTransactionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CardDetailPage]
class CardDetailRoute extends PageRouteInfo<CardDetailRouteArgs> {
  CardDetailRoute({
    Key? key,
    required int cardId,
    List<PageRouteInfo>? children,
  }) : super(
          CardDetailRoute.name,
          args: CardDetailRouteArgs(
            key: key,
            cardId: cardId,
          ),
          rawPathParams: {'cardId': cardId},
          initialChildren: children,
        );

  static const String name = 'CardDetailRoute';

  static const PageInfo<CardDetailRouteArgs> page =
      PageInfo<CardDetailRouteArgs>(name);
}

class CardDetailRouteArgs {
  const CardDetailRouteArgs({
    this.key,
    required this.cardId,
  });

  final Key? key;

  final int cardId;

  @override
  String toString() {
    return 'CardDetailRouteArgs{key: $key, cardId: $cardId}';
  }
}

/// generated route for
/// [CardEditPage]
class CardEditRoute extends PageRouteInfo<CardEditRouteArgs> {
  CardEditRoute({
    Key? key,
    required int cardId,
    List<PageRouteInfo>? children,
  }) : super(
          CardEditRoute.name,
          args: CardEditRouteArgs(
            key: key,
            cardId: cardId,
          ),
          rawPathParams: {'cardId': cardId},
          initialChildren: children,
        );

  static const String name = 'CardEditRoute';

  static const PageInfo<CardEditRouteArgs> page =
      PageInfo<CardEditRouteArgs>(name);
}

class CardEditRouteArgs {
  const CardEditRouteArgs({
    this.key,
    required this.cardId,
  });

  final Key? key;

  final int cardId;

  @override
  String toString() {
    return 'CardEditRouteArgs{key: $key, cardId: $cardId}';
  }
}

/// generated route for
/// [CardSettingsPage]
class CardSettingsRoute extends PageRouteInfo<CardSettingsRouteArgs> {
  CardSettingsRoute({
    Key? key,
    required int cardId,
    List<PageRouteInfo>? children,
  }) : super(
          CardSettingsRoute.name,
          args: CardSettingsRouteArgs(
            key: key,
            cardId: cardId,
          ),
          rawPathParams: {'cardId': cardId},
          initialChildren: children,
        );

  static const String name = 'CardSettingsRoute';

  static const PageInfo<CardSettingsRouteArgs> page =
      PageInfo<CardSettingsRouteArgs>(name);
}

class CardSettingsRouteArgs {
  const CardSettingsRouteArgs({
    this.key,
    required this.cardId,
  });

  final Key? key;

  final int cardId;

  @override
  String toString() {
    return 'CardSettingsRouteArgs{key: $key, cardId: $cardId}';
  }
}

/// generated route for
/// [CardsPage]
class CardsRoute extends PageRouteInfo<void> {
  const CardsRoute({List<PageRouteInfo>? children})
      : super(
          CardsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CardsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FormPage]
class FormRoute extends PageRouteInfo<void> {
  const FormRoute({List<PageRouteInfo>? children})
      : super(
          FormRoute.name,
          initialChildren: children,
        );

  static const String name = 'FormRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TransactionsPage]
class TransactionsRoute extends PageRouteInfo<TransactionsRouteArgs> {
  TransactionsRoute({
    Key? key,
    required int cardId,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionsRoute.name,
          args: TransactionsRouteArgs(
            key: key,
            cardId: cardId,
          ),
          rawPathParams: {'cardId': cardId},
          initialChildren: children,
        );

  static const String name = 'TransactionsRoute';

  static const PageInfo<TransactionsRouteArgs> page =
      PageInfo<TransactionsRouteArgs>(name);
}

class TransactionsRouteArgs {
  const TransactionsRouteArgs({
    this.key,
    required this.cardId,
  });

  final Key? key;

  final int cardId;

  @override
  String toString() {
    return 'TransactionsRouteArgs{key: $key, cardId: $cardId}';
  }
}
