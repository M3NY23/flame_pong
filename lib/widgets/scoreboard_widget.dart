import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pong/bloc/scoreboard/scoreboard_bloc.dart';

class ScoreboardWidget extends StatelessWidget {
  const ScoreboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardBloc>().state;

    const textStyle = TextStyle(fontSize: 100, color: Colors.white, fontFamily: "consoles");

    return Center(
      child: Row(
        children: [
          Text('${state.scoreboard.localScore}',
              style: textStyle),
          const SizedBox(width: 100),
          Text('${state.scoreboard.visitorScore}',
              style: textStyle),
        ],
      ),
    );
  }
}
