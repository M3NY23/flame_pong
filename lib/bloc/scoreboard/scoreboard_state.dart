part of 'scoreboard_bloc.dart';

@immutable
abstract class ScoreboardState  {

  final Scoreboard scoreboard;

  const ScoreboardState(this.scoreboard);
}

class ScoreboardInitialState extends ScoreboardState {
  ScoreboardInitialState() : super(Scoreboard(localScore: 0, visitorScore: 0));
}

class ScoreboardSetState extends ScoreboardState {
  const ScoreboardSetState({required Scoreboard scoreboard}) : super(scoreboard);
}