import '../models/track.dart';

class ApiService {
  Future<List<Track>> fetchTrendingTracks() async {
    await Future.delayed(const Duration(seconds: 1));
    return _allTracks;
  }

  Future<List<Track>> searchTracks(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _allTracks
        .where((track) =>
            track.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  final List<Track> _allTracks = [
    const Track(
      id: '1',
      title: 'Sample Song 1',
      artist: 'Artist Demo',
      artworkUrl: 'https://via.placeholder.com/300x300.png?text=Song+1',
      audioUrl:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    const Track(
      id: '2',
      title: 'Sample Song 2',
      artist: 'Artist Demo',
      artworkUrl: 'https://via.placeholder.com/300x300.png?text=Song+2',
      audioUrl:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    const Track(
      id: '3',
      title: 'Another Tune',
      artist: 'Musician X',
      artworkUrl: 'https://via.placeholder.com/300x300.png?text=Tune+A',
      audioUrl:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
  ];
}
