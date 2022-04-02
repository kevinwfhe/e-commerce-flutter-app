class Category {
  final String id, name;
  Category({
    required this.id,
    required this.name,
  });

  Category.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
