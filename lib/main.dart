import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:flame/input.dart';
import 'dart:developer';

import 'package:farm_game/components/kayisi.dart';
import 'package:farm_game/components/sepet.dart';
import 'package:farm_game/components/zemin.dart';

class FarmGame extends FlameGame with HasTappableComponents {
  final Random _random = Random();
  final int kayisiSayisi = 15;

  late Zemin zemin;
  late Sepet solSepet;
  late Sepet sagSepet;

  int toplananIyiKayisi = 0;
  int toplananKotuKayisi = 0;

  bool gameStarted = false;
  int kalanKayisi = 0;

  @override
  Future<void> onLoad() async {
    zemin = Zemin(size: size, position: Vector2.zero());
    await add(zemin);

    final sepetSize = Vector2.all(size.y * 0.25);

    solSepet = Sepet(
      type: SepetType.sol,
      position: Vector2(sepetSize.x / 2 + 20, size.y / 2),
      size: sepetSize,
      spawnPosition: Vector2(sepetSize.x / 2 + 20, size.y / 2),
    );
    await add(solSepet);

    sagSepet = Sepet(
      type: SepetType.sag,
      position: Vector2(size.x - sepetSize.x / 2 - 20, size.y / 2),
      size: sepetSize,
      spawnPosition: Vector2(size.x - sepetSize.x / 2 - 20, size.y / 2),
    );
    await add(sagSepet);

    _kayisiDagit();
    gameStarted = true;
  }

  void _kayisiDagit() {
    final minX = solSepet.size.x + 50;
    final maxX = size.x - sagSepet.size.x - 50;
    final minY = 50.0;
    final maxY = size.y - 50;

    for (int i = 0; i < kayisiSayisi; i++) {
      final type = _random.nextBool() ? KayisiType.iyi : KayisiType.kotu;
      final posX = minX + _random.nextDouble() * (maxX - minX);
      final posY = minY + _random.nextDouble() * (maxY - minY);

      final kayisi = Kayisi(
        type: type,
        position: Vector2(posX, posY),
        onTapped: _tutulanKayisi,
      );
      add(kayisi);
    }
    kalanKayisi = kayisiSayisi;
  }

  void _tutulanKayisi(Kayisi kayisi) {
    if (!gameStarted) return;
    if (kayisi.isRemoved) return;

    Vector2 hedefKonum;
    if (kayisi.type == KayisiType.iyi) {
      hedefKonum = sagSepet.spawnPosition;
      toplananIyiKayisi++;
      log('İyi Kayısı Toplandı! Toplam: $toplananIyiKayisi');
    } else {
      hedefKonum = solSepet.spawnPosition;
      toplananKotuKayisi++;
      print('Kötü Kayısı toplandı! Toplam: $toplananKotuKayisi');
    }

    kayisi.hareketEttir(
      hedefKonum,
      onCompleteCallBack: () {
        kayisi.removeFromParent();
        kalanKayisi--;

        if (kalanKayisi <= 0) {
          _endGame();
        }
      },
    );
  }

  void _endGame() {
    gameStarted = false;
    print('Oyun Bitti');
    print('Toplam iyi kayısı: $toplananIyiKayisi');
    print('toplam kötü kayısı: $toplananKotuKayisi');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final game = FarmGame();

  runApp(GameWidget(game: game));
}
