// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pong/models/scoreboard_model.dart';

part 'scoreboard_event.dart';
part 'scoreboard_state.dart';

class ScoreboardBloc extends Bloc<ScoreboardEvent, ScoreboardState> {
  ScoreboardBloc() : super(ScoreboardInitialState()) {
    on<PlayerGoalScoreboardEvent>((event, emit) =>
        emit(ScoreboardSetState(scoreboard: event.scoreboard)));
  }
}
