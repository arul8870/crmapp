import 'package:bloc/bloc.dart';
import 'package:crmapp/src/home/repo/home_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:logger/logger.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HomePageRepository _repository;
  final log = Logger();

  HomePageBloc({required HomePageRepository repository})
    : _repository = repository,
      super(HomePageState.initial) {
    on<InitializeHomePage>(_onInitializeHomePageToState);
  }

  Future<void> _onInitializeHomePageToState(
    HomePageEvent event,
    Emitter<HomePageState> emit,
  ) async {
    try {
      log.d("HomePageBloc:::_onInitializeHomePageToState::event: $event");
      emit(state.copyWith(status: () => HomePageStatus.loading));

      Map<String, dynamic> homePageData = await _repository.getHomePageData();

      List<Map<String, dynamic>> pendingTasks = [];

      emit(
        state.copyWith(
          status: () => HomePageStatus.success,
          homePageData: () => homePageData,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: () => HomePageStatus.failure,
          message: () => error.toString(),
        ),
      );
    }
  }
}
