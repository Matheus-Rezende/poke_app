class PokemonGenderData {
  final double male;
  final double female;

  PokemonGenderData({required this.male, required this.female});

  factory PokemonGenderData.fromRate(int rate) {
    if (rate == -1) return PokemonGenderData(male: 0, female: 0);

    final femalePercent = (rate / 8) * 100;
    final malePercent = 100 - femalePercent;

    return PokemonGenderData(male: malePercent, female: femalePercent);
  }

  bool get isUnknown => male == 0 && female == 0;
}
