sealed class ProfileEvent {
  const ProfileEvent();
}

class LoadProfileInfo extends ProfileEvent {
  const LoadProfileInfo();
}

class LoadProfileDetails extends ProfileEvent {
  const LoadProfileDetails();
}
