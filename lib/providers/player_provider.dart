import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/simple_audio_service.dart';

final audioServiceProvider = Provider<SimpleAudioService>((ref) {
  final service = SimpleAudioService();
  ref.onDispose(service.dispose);
  return service;
});
