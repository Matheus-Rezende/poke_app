import 'package:mobx/mobx.dart';
import 'package:poke_app/app/core/data/services/local_storage/local_storage.dart';
import 'package:poke_app/app/core/interactor/states/app_theme_state.dart';

part 'core_store.g.dart';

class CoreStore = CoreStoreBase with _$CoreStore;

abstract class CoreStoreBase with Store {
  final LocalStorage localStorage;

  CoreStoreBase({required this.localStorage});

  @observable
  AppThemeState themeState = AppThemeLightState();

  @computed
  bool get isLight => themeState is AppThemeLightState;

  final String themeKey = "isDarkTheme";

  @action
  changeTheme() async {
    if (themeState is AppThemeLightState) {
      themeState = themeState.darkTheme();
      localStorage.setItem(key: themeKey, value: true);
    } else if (themeState is AppThemeDarkState) {
      themeState = themeState.lightTheme();
      localStorage.setItem(key: themeKey, value: false);
    }
  }

  @action
  loadTheme() async {
    if (await localStorage.contains(key: themeKey) && await localStorage.getItem(key: themeKey)) {
      themeState = themeState.darkTheme();
    }
  }
}
