import 'package:flame/components.dart';

enum SepetType { sag, sol }

class Sepet extends SpriteComponent {
  final SepetType type;
  final Vector2 spawnPosition;

  Sepet({
    required this.type,
    required this.spawnPosition,
    super.position,
    required super.size,
  });

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      type == SepetType.sag ? 'sepet_sag.png' : 'sepet_sol.png',
    );
    anchor = Anchor.center;
  }
}
