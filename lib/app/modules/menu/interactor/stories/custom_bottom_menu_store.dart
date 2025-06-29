import 'package:mobx/mobx.dart';
part 'custom_bottom_menu_store.g.dart';

class CustomBottomMenuStore = CustomBottomMenuStoreBase with _$CustomBottomMenuStore;

abstract class CustomBottomMenuStoreBase with Store {
  @observable
  int selectedIndex = 0;

  @action
  void onItemTapped(int index) {
    selectedIndex = index;
  }
}
