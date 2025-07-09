import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/modules/regions/ui/pages/region_details_page.dart';

class RegionsModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/details',
      child: (context) => RegionDetailsPage(arguments: r.args.data),
      transition: TransitionType.rightToLeftWithFade,
    );
    super.routes(r);
  }
}
