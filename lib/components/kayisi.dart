import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

enum KayisiType { iyi, kotu }

class Kayisi extends SpriteComponent with TapCallbacks {
  final KayisiType type;
  final Function(Kayisi) onTapped;

  Kayisi({
    required this.type,
    required this.onTapped,
    super.position,
    required super.size,
  });

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      type == KayisiType.iyi ? 'saglam_kayisi.png' : 'curuk_kayisi.png',
    );

    anchor = Anchor.center;
  }

  @override
  void onTapDown(TapDownEvent event) {
    log('Kayısıya tıklandı: ${type == KayisiType.iyi ? "sağlam" : "Çürük"}');
    onTapped.call(this);
  }

  void hareketEttir(Vector2 targetPosition) {
    add(
      MoveToEffect(
        targetPosition,
        EffectController(duration: 0.5, curve: Curves.easeOut),
        onComplete: () {
          log('kayısı hedefe ulaştı');
        },
      ),
    );
  }
}
