sealed class ProfileEvent {
  const ProfileEvent();
}

class LoadProfileInfo extends ProfileEvent {
  const LoadProfileInfo();
}

class LoadProfileDetails extends ProfileEvent {
  const LoadProfileDetails();
}

// Test senaryoları için yeni event'ler
class TestProfileError extends ProfileEvent {
  const TestProfileError();
}

class TestProfileNoContent extends ProfileEvent {
  const TestProfileNoContent();
}

class TestProfileSuccess extends ProfileEvent {
  const TestProfileSuccess();
}
