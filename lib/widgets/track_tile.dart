import 'package:flutter/material.dart';
import '../models/track.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  final VoidCallback onPlay;

  const TrackTile({super.key, required this.track, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        track.artworkUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(track.title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(
        track.artist,
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.play_arrow, color: Colors.white),
        onPressed: onPlay,
      ),
    );
  }
}
