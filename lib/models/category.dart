class Category {
  final String id;
  final String name;
  final String image;

  Category({required this.id, required this.name, required this.image});
}

final sampleCategories = [
  Category(
      id: 'c1', name: 'Plain Khakhra', image: 'lib/assets/images/plain.png'),
  Category(
      id: 'c2', name: 'Masala Khakhra', image: 'lib/assets/images/masala.png'),
];
