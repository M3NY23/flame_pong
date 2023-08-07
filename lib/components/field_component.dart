import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong/components/ball_component.dart';
import 'package:pong/components/goal_component.dart';
import 'package:pong/components/player_component.dart';
import 'package:pong/components/wall_component.dart';

/// This class is responsible for painting the field
class FieldComponent extends PositionComponent with HasGameRef {
  final double padding = 20, screenOffset = 20;
  final Paint fieldPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke;
  final Vector2 playersSize = Vector2(20, 200);
  final double ballRadius = 20;
  final double scoreBoardWidth = 200;
  late Vector2 playerPosition, enemyPosition;

  @override
  Future<void> onLoad() async {
    size = gameRef.size;
    playerPosition = Vector2(padding * 2, (size.y / 2) - (playersSize.y / 2));
    enemyPosition = Vector2(size.x - padding - (screenOffset * 2),
        (size.y / 2) - (playersSize.y / 2));

    final WallComponent topWallComponent =
        WallComponent(size: Vector2(size.x, padding), position: Vector2.all(0));

    final WallComponent bottomWallComponent = WallComponent(
        size: Vector2(size.x, padding),
        position: Vector2(0, size.y - screenOffset));

    final double goalHeight = size.y - (padding * 2);

    final GoalComponent localGoalComponent = GoalComponent(
        size: Vector2(padding, goalHeight),
        position: Vector2(0, (size.y / 2 - (goalHeight / 2))));

    final GoalComponent visitorGoalComponent = GoalComponent(
        size: Vector2(padding, goalHeight),
        position: Vector2(size.x - padding, (size.y / 2 - (goalHeight / 2))));

    final PlayerComponent localPlayerComponent = PlayerComponent(
        size: playersSize,
        position: playerPosition,
        moveDownKey: LogicalKeyboardKey.keyS,
        moveUpKey: LogicalKeyboardKey.keyW);

    final PlayerComponent visitorPlayerComponent = PlayerComponent(
        size: playersSize,
        position: enemyPosition,
        moveDownKey: LogicalKeyboardKey.arrowDown,
        moveUpKey: LogicalKeyboardKey.arrowUp);

    final BallComponent ballComponent = BallComponent(
        radius: ballRadius,
        position:
            Vector2((size.x / 2) - ballRadius, (size.y / 2) - ballRadius));

    addAll([
      topWallComponent,
      bottomWallComponent,
      localGoalComponent,
      visitorGoalComponent,
      localPlayerComponent,
      visitorPlayerComponent,
      ballComponent
    ]);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTWH(padding, padding, size.x - (padding + screenOffset),
            size.y - (padding + screenOffset)),
        fieldPaint);
    canvas.drawLine(Offset(size.x / 2, padding),
        Offset(size.x / 2, size.y - padding), fieldPaint);
    super.render(canvas);
  }
}
