import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/modules/auth/ui/pages/pre_auth_page.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/pre-auth-page', child: (context) => PreAuthPage(args: r.args.data));
    super.routes(r);
  }
}
