part of 'scoreboard_bloc.dart';

@immutable
abstract class ScoreboardEvent {
  const ScoreboardEvent();
}

class PlayerGoalScoreboardEvent extends ScoreboardEvent {
  final Scoreboard scoreboard;
  const PlayerGoalScoreboardEvent(this.scoreboard); 
}