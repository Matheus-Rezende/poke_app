import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/data/services/http/http_service_impl.dart';
import 'package:poke_app/app/core/data/services/local_storage/local_storage.dart';
import 'package:poke_app/app/core/data/services/local_storage/local_storage_shared_impl.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addInstance(AppTheme());
    i.add<HttpService>(HttpServiceImp.new);
    i.addLazySingleton<LocalStorage>(LocalStorageSharedImpl.new);
    super.exportedBinds(i);
  }
}
