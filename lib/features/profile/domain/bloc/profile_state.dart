import 'package:bloc_management/core/base/base_state.dart';
import 'package:bloc_management/features/profile/data/models/profile_model.dart';

abstract class ProfileState extends BaseState<ProfileModel> {
  const ProfileState({
    super.data,
    super.error,
    super.isLoading = false,
  });
}

class ProfileInitial extends ProfileState {
  const ProfileInitial() : super();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading() : super(isLoading: true);
}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;

  const ProfileLoaded({
    required this.profile,
  }) : super(data: profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;
  final String type;

  const ProfileError({
    required this.message,
    this.type = 'toast',
  }) : super(error: message);

  @override
  List<Object?> get props => [message, type];
}
