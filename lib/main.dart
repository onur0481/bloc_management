import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/di/injection.dart';
import 'package:bloc_management/core/router/app_router.dart';
import 'package:bloc_management/features/home/domain/bloc/home_bloc.dart';
import 'package:bloc_management/features/home/domain/bloc/home_event.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_event.dart';

final _appRouter = AppRouter();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeBloc>()..add(const LoadHome()),
        ),
        BlocProvider(
          create: (context) => getIt<CardsBloc>()..add(LoadCards()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Kart Yönetimi',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
