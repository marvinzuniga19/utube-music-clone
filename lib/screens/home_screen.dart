import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: implementation_imports
import 'package:riverpod/src/framework.dart';
import '../providers/search_provider.dart';
import '../widgets/track_tile.dart';
import '../widgets/bottom_player_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  ProviderListenable? get playerProvider => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(searchProvider.select((s) => s.rawQuery));
    final tracksAsync = ref.watch(searchProvider).rawQuery.isEmpty
        ? ref.watch(trendingTracksProvider)
        : ref.watch(searchResultsProvider);
    final audioPlayer = ref.watch(playerProvider!);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (query) {
            ref.read(searchProvider.notifier).onSearchChanged(query);
          },
          decoration: InputDecoration(
            hintText: 'Buscar canciones, artistas...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white54),
          ),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
      body: tracksAsync.when(
        data: (tracks) => ListView.builder(
          itemCount: tracks.length,
          itemBuilder: (context, index) {
            final track = tracks[index];
            return TrackTile(
              track: track,
              onPlay: () async {
                await audioPlayer.setUrl(track.audioUrl);
                audioPlayer.play();
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      bottomNavigationBar: const BottomPlayerBar(),
    );
  }
}
