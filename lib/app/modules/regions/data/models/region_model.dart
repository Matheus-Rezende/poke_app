class RegionModel {
  final int id;
  final String name;
  final String url;

  RegionModel({required this.name, required this.url, required this.id});

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    final url = (json['url']) as String;
    final id = int.parse(url.split('/')[url.split('/').length - 2]);

    return RegionModel(name: json['name'], url: url, id: id);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url, 'id': id};
  }
}
