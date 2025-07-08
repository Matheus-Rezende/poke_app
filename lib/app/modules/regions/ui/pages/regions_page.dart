import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/interactor/utils/extensions/string_casing_extension.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/core/ui/widgets/messages/message_widget.dart';
import 'package:poke_app/app/modules/regions/interactor/states/regions_state.dart';
import 'package:poke_app/app/modules/regions/interactor/stories/regions_store.dart';
import 'package:poke_app/app/modules/regions/interactor/utils/arguments/region_arguments.dart';
import 'package:poke_app/app/modules/regions/ui/widgets/pokemon_region_card_widget.dart';

class RegionsPage extends StatefulWidget {
  const RegionsPage({super.key});

  @override
  State<RegionsPage> createState() => _RegionsPageState();
}

class _RegionsPageState extends State<RegionsPage> {
  final appTheme = Modular.get<AppTheme>();
  final regionsStore = Modular.get<RegionsStore>();

  @override
  void initState() {
    super.initState();
    regionsStore.getRegions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colors.whiteColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomAppBarWidget(
              padding: EdgeInsets.only(top: 46.0),
              backgroundColor: appTheme.colors.whiteColor,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Regiões',
                      style: appTheme.typography.poppins18px().copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: appTheme.colors.greyE6Color, height: 1.0),
                  ),
                  Observer(
                    builder: (context) {
                      return switch (regionsStore.regionsState) {
                        InitRegionsState() => Container(),
                        LoadingRegionsState() => CustomLoadingWidget(isSliverWidget: false),
                        SuccessRegionsState(:final regions) => Column(
                          children: List.generate(regions.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                              child: PokemonRegionCardWidget(
                                regionName: regions[index].name.toCapitalized,
                                generationNumber: regions[index].id,
                                backgroundImagePath: getRegionImage(regions[index].id),
                                onPressed: () => Modular.to.pushNamed(
                                  AppRoutes.regionDetails(),
                                  arguments: RegionArguments(
                                    url: regions[index].url,
                                    regionName: regions[index].name,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        ErrorRegionsState(:final message) => MessageWidget(
                          theme: appTheme,
                          title: message,
                          useSliverWidget: false,

                          padding: EdgeInsetsGeometry.only(left: 16.0, right: 16.0, top: 56.0),
                        ),
                      };
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getRegionImage(int regionNumber) {
    switch (regionNumber) {
      case 1:
        return 'assets/images/png/regions/region_kanto.png';
      case 2:
        return 'assets/images/png/regions/region_johto.png';
      case 3:
        return 'assets/images/png/regions/region_hoenn.png';
      case 4:
        return 'assets/images/png/regions/region_sinnoh.png';
      case 5:
        return 'assets/images/png/regions/region_unova.png';
      case 6:
        return 'assets/images/png/regions/region_kalos.png';
      case 7:
        return 'assets/images/png/regions/region_alola.png';
      case 8:
        return 'assets/images/png/regions/region_galar.png';
      case 9:
        return 'assets/images/png/regions/region_hisui.webp';
      case 10:
        return 'assets/images/png/regions/region_paldea.jpg';
      default:
        return 'assets/images/png/regions/region_kanto.png';
    }
  }
}
