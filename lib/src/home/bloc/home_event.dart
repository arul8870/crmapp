part of "home_bloc.dart";

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class InitializeHomePage extends HomePageEvent {
  const InitializeHomePage();
}
