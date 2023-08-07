import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class WallComponent extends PositionComponent {
  WallComponent({required Vector2 size, required Vector2 position})
      : super(size: size, position: position);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    return super.onLoad();
  }
}
