import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/track.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class SearchState {
  final String rawQuery;
  final String debouncedQuery;

  SearchState({this.rawQuery = '', this.debouncedQuery = ''});

  SearchState copyWith({String? rawQuery, String? debouncedQuery}) {
    return SearchState(
      rawQuery: rawQuery ?? this.rawQuery,
      debouncedQuery: debouncedQuery ?? this.debouncedQuery,
    );
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState());

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void onSearchChanged(String query) {
    state = state.copyWith(rawQuery: query);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      state = state.copyWith(debouncedQuery: query);
    });
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((
  ref,
) {
  return SearchNotifier();
});

final trendingTracksProvider = FutureProvider<List<Track>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.fetchTrendingTracks();
});

final searchResultsProvider = FutureProvider<List<Track>>((ref) async {
  final api = ref.read(apiServiceProvider);
  final query = ref.watch(searchProvider.select((s) => s.debouncedQuery));
  if (query.isEmpty) {
    return [];
  }
  return api.searchTracks(query);
});
