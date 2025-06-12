import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'get_it_extensions.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_bloc.dart';
import 'package:bloc_management/features/profile/data/repositories/profile_repository.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.registerRepositories();
  getIt.registerBlocs();
  getIt.registerHomeBloc();
  getIt.registerFactory<ProfileRepository>(() => ProfileRepository());
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(getIt<ProfileRepository>()));
}
