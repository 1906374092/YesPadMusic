class CategoryModel {
  final num id;
  final String name;
  final num type;
  final num category;
  final bool hot;
  CategoryModel(
      {required this.id,
      required this.name,
      required this.type,
      required this.category,
      required this.hot});
  factory CategoryModel.fromMap(Map map) {
    return CategoryModel(
        id: map['id'],
        name: map['name'],
        type: map['type'],
        category: map['category'],
        hot: map['hot']);
  }
}
