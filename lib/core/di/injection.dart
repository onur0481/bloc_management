import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'get_it_extensions.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.registerRepositories();
  getIt.registerBlocs();
  getIt.registerHomeBloc();
}
