import 'package:bloc_management/features/profile/domain/bloc/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/profile/data/repositories/profile_repository.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository)
      : super(const ProfileState(
          infoState: ProfileInfoInitial(),
          detailsState: ProfileDetailsInitial(),
        )) {
    on<LoadProfileInfo>(_onLoadProfileInfo);
    on<LoadProfileDetails>(_onLoadProfileDetails);
  }

  Future<void> _onLoadProfileInfo(
    LoadProfileInfo event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(infoState: const ProfileInfoLoading()));

    final response = await _repository.getProfile();
    response.when(
      success: (data) => emit(state.copyWith(infoState: ProfileInfoLoaded(data))),
      error: (message, type) => emit(state.copyWith(infoState: ProfileInfoError(message, type: type))),
      noContent: () => emit(state.copyWith(infoState: const ProfileInfoError('Veri bulunamadı'))),
    );
  }

  Future<void> _onLoadProfileDetails(
    LoadProfileDetails event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(detailsState: const ProfileDetailsLoading()));

    final response = await _repository.getProfileDetails();
    response.when(
      success: (data) => emit(state.copyWith(detailsState: ProfileDetailsLoaded(data))),
      error: (message, type) => emit(state.copyWith(detailsState: ProfileDetailsError(message, type: type))),
      noContent: () => emit(state.copyWith(detailsState: const ProfileDetailsError('Veri bulunamadı'))),
    );
  }
}
