import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/player_provider.dart';

class BottomPlayerBar extends ConsumerWidget {
  const BottomPlayerBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audio = ref.watch(audioServiceProvider);
    return StreamBuilder<bool>(
      stream: audio.player.playingStream,
      builder: (context, snapshot) {
        final isPlaying = snapshot.data ?? false;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reproduciendo muestra...',
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: Icon(
                  isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: () {
                  isPlaying ? audio.pause() : audio.play();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
