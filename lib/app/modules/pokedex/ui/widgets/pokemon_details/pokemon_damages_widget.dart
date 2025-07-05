import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/interactor/utils/translator/pokemon_type_translator.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_damage_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_types/types_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/type_badge_widget.dart';

class PokemonDamagesWidget extends StatefulWidget {
  final List<String> urls;

  const PokemonDamagesWidget({super.key, required this.urls});

  @override
  State<PokemonDamagesWidget> createState() => _PokemonDamagesWidgetState();
}

class _PokemonDamagesWidgetState extends State<PokemonDamagesWidget> {
  final appTheme = Modular.get<AppTheme>();
  final store = Modular.get<TypesPokemonStore>();
  String? _lastHash;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.urls.isNotEmpty) {
      final hash = widget.urls.join(',');
      if (_lastHash != hash) {
        _lastHash = hash;
        store.loadCombinedTypeDamages(widget.urls);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Fraquezas',
            style: appTheme.typography.poppins18px().copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Observer(
          builder: (_) {
            return switch (store.pokemonTypeDamageState) {
              InitPokemonTypeDamageState() => Container(),
              LoadingPokemonTypeDamageState() => const CustomLoadingWidget(isSliverWidget: false),
              SuccessPokemonTypeDamageState(:final typeDamage) => GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8.0, bottom: 32.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5,
                  mainAxisSpacing: 16.0,
                ),
                children: typeDamage.damages!
                    .map(
                      (type) => TypeBadgeWidget(
                        type: pokemonTypeTranslation[type] ?? type,
                        theme: appTheme,
                        isContentCentralized: true,
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    )
                    .toList(),
              ),
              ErrorPokemonTypeDamageState(:final message) => Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                child: Text(
                  message,
                  style: appTheme.typography.poppins14px().copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            };
          },
        ),
      ],
    );
  }
}
