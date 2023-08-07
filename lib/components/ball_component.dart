import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pong/components/goal_component.dart';
import 'package:pong/components/player_component.dart';
import 'package:pong/components/wall_component.dart';
import 'package:pong/pong_game.dart';

enum BallDirection { rightUp, rightDown, leftDown, leftUp, idle }

class BallComponent extends CircleComponent
    with
        CollisionCallbacks,
        HasGameRef<PongGame>{
  double velocity = 480;
  late BallDirection direction;
  late Vector2 originalPosition;

  BallComponent({required double radius, required Vector2 position})
      : super(radius: radius, position: position) {
    originalPosition = position;
  }

  @override
  Future<void> onLoad() async {
    direction = BallDirection.leftDown;
    add(CircleHitbox());
    super.onLoad();
  }

  void move(dt) {
    switch (direction) {
      case BallDirection.leftUp:
        position.x -= dt * velocity;
        position.y -= dt * velocity;
        break;
      case BallDirection.leftDown:
        position.x -= dt * velocity;
        position.y += dt * velocity;
        break;
      case BallDirection.rightDown:
        position.x += dt * velocity;
        position.y += dt * velocity;
        break;
      case BallDirection.rightUp:
        position.x += dt * velocity;
        position.y -= dt * velocity;
        break;
      default:
        break;
    }
  }

  @override
  void update(double dt) {
    move(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is WallComponent) {
      if (intersectionPoints.first[1] <= 20) {
        if (direction == BallDirection.leftUp) {
          direction = BallDirection.leftDown;
        } else {
          direction = BallDirection.rightDown;
        }
      } else {
        if (direction == BallDirection.leftDown) {
          direction = BallDirection.leftUp;
        } else {
          direction = BallDirection.rightUp;
        }
      }
    }

    if (other is PlayerComponent) {
      if (intersectionPoints.first[0] < gameRef.size.x / 2) {
        if (direction == BallDirection.leftUp) {
          direction = BallDirection.rightUp;
        } else {
          direction = BallDirection.rightDown;
        }
      } else {
        if (direction == BallDirection.rightUp) {
          direction = BallDirection.leftUp;
        } else {
          direction = BallDirection.leftDown;
        }
      }
    }

    if (other is GoalComponent) {
      int visitorScore = gameRef.scoreboardBloc.state.scoreboard.visitorScore,
          localScore = gameRef.scoreboardBloc.state.scoreboard.localScore;

      position = originalPosition;

      if (intersectionPoints.first[0] < gameRef.size.x / 2) {
        visitorScore++;
      } else {
        localScore++;
      }
      print(localScore.toString() + " - "  + visitorScore.toString());
      gameRef.changeScoreBoard(localScore, visitorScore);
    }
    super.onCollision(intersectionPoints, other);
  }
}
