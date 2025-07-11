import 'package:flame/components.dart';

class Zemin extends SpriteComponent {
  Zemin({super.position, required super.size});
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('zemin.png');
  }
}
