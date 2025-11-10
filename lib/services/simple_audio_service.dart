import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class SimpleAudioService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> setUrl(String url) async {
    try {
      await _player.setUrl(url);
    } catch (e) {
      if (kDebugMode) {
        print('Error al cargar URL: $e');
      }
    }
  }

  void play() => _player.play();
  void pause() => _player.pause();
  void dispose() => _player.dispose();
}
