abstract class ProfileState {
  ProfileState();

  ProfileState copyWith();
}

class ProfileInitial extends ProfileState {
  ProfileInitial() : super();

  @override
  ProfileState copyWith() => ProfileInitial();
}

class ProfileLoading extends ProfileState {
  ProfileLoading() : super();

  @override
  ProfileState copyWith() => ProfileLoading();
}

class ProfileData extends ProfileState {
  ProfileData();

  @override
  ProfileState copyWith() => ProfileData();
}

class ProfileError extends ProfileState {
  ProfileError() : super();

  @override
  ProfileState copyWith() => ProfileError();
}
