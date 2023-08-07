import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pong/components/wall_component.dart';

enum Direction { down, up, idle }

class PlayerComponent extends RectangleComponent
    with KeyboardHandler, CollisionCallbacks {
  int fps = 480;
  Direction direction = Direction.idle;
  bool isOnTop = false, isOnFloor = false;

  final LogicalKeyboardKey moveUpKey;
  final LogicalKeyboardKey moveDownKey;

  PlayerComponent(
      {required Vector2 size,
      required Vector2 position,
      required this.moveUpKey,
      required this.moveDownKey})
      : super(size: size, position: position);

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    move(dt, direction);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(moveDownKey)) {
      direction = Direction.down;
    } else if (keysPressed.contains(moveUpKey)) {
      direction = Direction.up;
    } else {
      direction = Direction.idle;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void move(double dt, Direction direction) {
    switch (direction) {
      case Direction.down:
        if (!isOnFloor) {
          position.y += (dt * fps);
        }
        break;
      case Direction.up:
        if (!isOnTop) {
          position.y -= (dt * fps);
        }
        break;
      default:
        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is WallComponent) {
      if (intersectionPoints.first[1] <= 20) {
        isOnTop = true;
      } else {
        isOnFloor = true;
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    isOnFloor = false;
    isOnTop = false;
    super.onCollisionEnd(other);
  }
}
