class ClientMeta {
  final String description;
  final String url;
  final icons;
  final String name;

  ClientMeta({this.description, this.url, this.icons, this.name});

  ClientMeta.fromJson(Map<String, dynamic> json)
    :description = json['description'],
    url = json['url'],
    icons = json['icons'],
    name = json['name'];

  Map<String, dynamic> toJson() =>
    {
      'description': description,
      'url': url,
      'icons' : icons,
      'name' : name,
    };
}