import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:pong/bloc/scoreboard/scoreboard_bloc.dart';
import 'package:pong/components/field_component.dart';

import 'models/scoreboard_model.dart';

class PongGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final ScoreboardBloc scoreboardBloc;

  PongGame(this.scoreboardBloc);

  @override
  Future<void> onLoad() async {
    debugMode = true;
    await add(
      FlameBlocProvider<ScoreboardBloc, ScoreboardState>(
          create: () => ScoreboardBloc(),
          children: [
            FieldComponent(),
          ]),
    );
  }

  void changeScoreBoard(localScore, visitorScore) {
    scoreboardBloc.add(PlayerGoalScoreboardEvent(
        Scoreboard(localScore: localScore, visitorScore: visitorScore)));
  }
}
