import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/core/base/base_bloc.dart';

import 'package:bloc_management/features/profile/data/repositories/profile_repository.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_event.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_state.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<LoadProfileWithError>(_onLoadProfileWithError);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await handleLoading(emit, (isLoading) => ProfileLoading());

      final response = await _repository.getProfile();

      if (response.isSuccess && response.data != null) {
        emit(ProfileLoaded(profile: response.data!));
      } else {
        emit(ProfileError(
          message: response.message ?? 'Bir hata oluştu',
          type: response.type ?? 'toast',
        ));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onLoadProfileWithError(
    LoadProfileWithError event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await handleLoading(emit, (isLoading) => ProfileLoading());

      final response = await _repository.getProfileWithError();

      if (response.isSuccess && response.data != null) {
        emit(ProfileLoaded(profile: response.data!));
      } else {
        emit(ProfileError(
          message: response.message ?? 'Bir hata oluştu',
          type: response.type ?? 'toast',
        ));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
