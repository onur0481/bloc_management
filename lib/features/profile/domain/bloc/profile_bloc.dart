import 'package:bloc_management/core/base/base_state.dart';
import 'package:bloc_management/features/profile/data/models/profile_details_model.dart';
import 'package:bloc_management/features/profile/data/models/profile_model.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/profile/data/repositories/profile_repository.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_state.dart';
import 'package:bloc_management/core/base/handle_api_call_mixin.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with HandleApiCallMixin {
  final ProfileRepository _repository;

  ProfileBloc(this._repository)
      : super(const ProfileState(
          profileState: InitialState(),
          detailsState: InitialState(),
        )) {
    on<LoadProfileInfo>(_onLoadProfileInfo);
    on<LoadProfileDetails>(_onLoadProfileDetails);
    on<TestProfileError>((event, emit) => _onTestProfileError(event, emit));
    on<TestProfileNoContent>((event, emit) => _onTestProfileNoContent(event, emit));
    on<TestProfileSuccess>((event, emit) => _onTestProfileSuccess(event, emit));
  }

  Future<void> _onLoadProfileInfo(
    LoadProfileInfo event,
    Emitter<ProfileState> emit,
  ) async {
    await handleApiCall<ProfileModel>(
      apiCall: _repository.getProfile,
      emitState: (state) => emit(ProfileState(
        profileState: state,
        detailsState: this.state.detailsState,
      )),
    );
  }

  Future<void> _onLoadProfileDetails(
    LoadProfileDetails event,
    Emitter<ProfileState> emit,
  ) async {
    await handleApiCall<ProfileDetailsModel>(
      apiCall: _repository.getProfileDetails,
      emitState: (state) => emit(ProfileState(
        profileState: this.state.profileState,
        detailsState: state,
      )),
    );
  }

  Future<void> _onTestProfileError(
    TestProfileError event,
    Emitter<ProfileState> emit,
  ) async {
    _repository.setResponseType('error');
    add(const LoadProfileInfo());
  }

  Future<void> _onTestProfileNoContent(
    TestProfileNoContent event,
    Emitter<ProfileState> emit,
  ) async {
    _repository.setResponseType('noContent');
    add(const LoadProfileInfo());
  }

  Future<void> _onTestProfileSuccess(
    TestProfileSuccess event,
    Emitter<ProfileState> emit,
  ) async {
    _repository.setResponseType('');
    add(const LoadProfileInfo());
  }
}
