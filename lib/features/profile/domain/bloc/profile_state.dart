import 'package:bloc_management/core/base/base_state.dart';
import 'package:bloc_management/features/profile/data/models/profile_model.dart';
import 'package:bloc_management/features/profile/data/models/profile_details_model.dart';

class ProfileState {
  final BaseState<ProfileModel> profileState;
  final BaseState<ProfileDetailsModel> detailsState;

  const ProfileState({
    required this.profileState,
    required this.detailsState,
  });

  ProfileState copyWith({
    BaseState<ProfileModel>? profileState,
    BaseState<ProfileDetailsModel>? detailsState,
  }) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
      detailsState: detailsState ?? this.detailsState,
    );
  }
}
