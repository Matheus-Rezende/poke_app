import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/data/services/http/http_service_impl.dart';
import 'package:poke_app/app/core/data/services/local_notifications/local_notifications.dart';
import 'package:poke_app/app/core/data/services/local_notifications/local_notifications_impl.dart';
import 'package:poke_app/app/core/data/services/local_storage/local_storage.dart';
import 'package:poke_app/app/core/data/services/local_storage/local_storage_shared_impl.dart';
import 'package:poke_app/app/core/interactor/stories/core_store.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/modules/notifications/interactor/stories/notifications_store.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addInstance(AppTheme());
    i.add<HttpService>(HttpServiceImp.new);
    i.addLazySingleton<LocalStorage>(LocalStorageSharedImpl.new);
    i.addLazySingleton<LocalNotifications>(LocalNotificationsImpl.new);
    i.addLazySingleton(CoreStore.new);
    i.addLazySingleton(NotificationsStore.new);

    super.exportedBinds(i);
  }
}
