import 'package:bloc_management/features/profile/data/models/profile_model.dart';
import 'package:bloc_management/features/profile/data/models/profile_details_model.dart';

sealed class ProfileInfoState {
  const ProfileInfoState();
}

class ProfileInfoInitial extends ProfileInfoState {
  const ProfileInfoInitial();
}

class ProfileInfoLoading extends ProfileInfoState {
  const ProfileInfoLoading();
}

class ProfileInfoLoaded extends ProfileInfoState {
  final ProfileModel profile;
  const ProfileInfoLoaded(this.profile);
}

class ProfileInfoError extends ProfileInfoState {
  final String message;
  final String? type;
  const ProfileInfoError(this.message, {this.type = 'toast'});
}

sealed class ProfileDetailsState {
  const ProfileDetailsState();
}

class ProfileDetailsInitial extends ProfileDetailsState {
  const ProfileDetailsInitial();
}

class ProfileDetailsLoading extends ProfileDetailsState {
  const ProfileDetailsLoading();
}

class ProfileDetailsLoaded extends ProfileDetailsState {
  final ProfileDetailsModel details;
  const ProfileDetailsLoaded(this.details);
}

class ProfileDetailsError extends ProfileDetailsState {
  final String message;
  final String? type;
  const ProfileDetailsError(this.message, {this.type = 'toast'});
}

class ProfileState {
  final ProfileInfoState infoState;
  final ProfileDetailsState detailsState;

  const ProfileState({
    required this.infoState,
    required this.detailsState,
  });

  ProfileState copyWith({
    ProfileInfoState? infoState,
    ProfileDetailsState? detailsState,
  }) {
    return ProfileState(
      infoState: infoState ?? this.infoState,
      detailsState: detailsState ?? this.detailsState,
    );
  }
}
