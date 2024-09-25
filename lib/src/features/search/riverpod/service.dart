import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tags/src/data/hivekeys.dart';
import 'package:tags/src/data/localdatabase.dart';

class SearchNotifier extends StateNotifier<String> {
  SearchNotifier() : super('') {
    loadSearchText();
  }

  // Load search text from HiveStorage
  void loadSearchText() {
    String? searchText = HiveStorage.get(HiveKeys.search);
    if (searchText != null) {
      state = searchText;
    }
  }

  // Update search text both in the state and HiveStorage
  void updateSearchText(String newText) {
    state = newText;
    HiveStorage.put(
      HiveKeys.search,
      newText,
    ); // Save the updated search text to HiveStorage
  }
}

// Provider for SearchNotifier
final searchProvider =
    StateNotifierProvider<SearchNotifier, String>((ref) => SearchNotifier());
