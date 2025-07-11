import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';

class FarmGame extends FlameGame {
  late SpriteComponent ground;

  @override
  Future<void> onLoad() async {
    final groundImage = await images.load('zemin.png');

    ground = SpriteComponent(
      sprite: Sprite(groundImage),
      size: size,
      position: Vector2.zero(),
    );

    add(ground);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final game = FarmGame();

  runApp(GameWidget(game: game));
}
