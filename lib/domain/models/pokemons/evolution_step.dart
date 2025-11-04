class EvolutionStep {
  final String number;
  final String name;
  final String image;
  final List<String> types;
  final String? triggerDescription;

  EvolutionStep({
    required this.number,
    required this.name,
    required this.image,
    required this.types,
    this.triggerDescription,
  });
}
