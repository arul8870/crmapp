part of 'home_bloc.dart';

enum HomePageStatus {
  initial,
  loading,
  success,
  failure,
  updateMenu,
  updateContent,
}

enum MenuStatus { open, shrunk, closed }

final class HomePageState extends Equatable {
  final HomePageStatus status;
  final String? message;
  final Map<String, dynamic> homePageData;

  const HomePageState({
    required this.status,
    required this.homePageData,

    this.message,
  });

  static const initial = HomePageState(
    message: "",
    homePageData: {},

    status: HomePageStatus.initial,
  );

  HomePageState copyWith({
    String Function()? message,

    Map<String, dynamic> Function()? homePageData,
    HomePageStatus Function()? status,

    String Function()? selectedDataFilter,
  }) {
    return HomePageState(
      status: status != null ? status() : this.status,

      homePageData: homePageData != null ? homePageData() : this.homePageData,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object?> get props => [status, homePageData];
}
