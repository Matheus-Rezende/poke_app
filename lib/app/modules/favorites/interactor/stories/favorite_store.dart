import 'package:mobx/mobx.dart';
part 'favorite_store.g.dart';

class FavoriteStore = FavoriteStoreBase with _$FavoriteStore;

abstract class FavoriteStoreBase with Store {
  @observable
  ObservableMap<int, bool> favorites = ObservableMap<int, bool>();

  @action
  void toggleFavorite(int id) {
    favorites[id] = !(favorites[id] ?? false);
  }

  bool isFavorite(int id) => favorites[id] ?? false;

  @action
  String getFavoriteImagePath(int id) {
    return isFavorite(id)
        ? 'assets/icons/svg/pokemons/favorite/favorite_with_border_filled_icon.svg'
        : 'assets/icons/svg/pokemons/favorite/favorite_with_border_icon.svg';
  }
}
