import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pong/bloc/scoreboard/scoreboard_bloc.dart';
import 'package:pong/pong_game.dart';
import 'package:pong/widgets/scoreboard_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ScoreboardBloc>(create: (_) => ScoreboardBloc())
        ],
        child: const GameView(),
      ),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(child: Game()),
              Positioned(
                top: 10,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScoreboardWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: PongGame(context.read<ScoreboardBloc>()),
    );
  }
}
