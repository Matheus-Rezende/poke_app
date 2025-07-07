import 'package:mobx/mobx.dart';
import 'package:poke_app/app/modules/regions/interactor/repositories/regions_repository.dart';
import 'package:poke_app/app/modules/regions/interactor/states/regions_state.dart';
part 'regions_store.g.dart';

class RegionsStore = RegionsStoreBase with _$RegionsStore;

abstract class RegionsStoreBase with Store {
  final RegionsRepository regionsRepository;
  RegionsStoreBase({required this.regionsRepository});

  @observable
  RegionsState regionsState = InitRegionsState();

  @action
  Future<void> getRegions() async {
    regionsState = regionsState.loading();
    final result = await regionsRepository.fetchRegions();
    result.fold(
      (failure) => regionsState = ErrorRegionsState(message: failure.message),
      (success) => regionsState = SuccessRegionsState(regions: success.regions),
    );
  }
}
