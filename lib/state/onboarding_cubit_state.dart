abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int currentPage;
  final bool isLastPage;

  OnboardingPageChanged(this.currentPage, this.isLastPage);
}

class InternetCheckOnState extends OnboardingState {
  final bool isConnected;

  InternetCheckOnState({required this.isConnected});
}

class InternetCheckOffState extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}
