class Product {
  final String id;
  final String categoryId;
  final String name;
  final String image;
  final double price;

  Product(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.image,
      required this.price});
}

final sampleProducts = [
  Product(
      id: 'p1',
      categoryId: 'c1',
      name: 'Plain Khakhra 200g',
      image: 'lib/assets/images/plain.png',
      price: 40.0),
  Product(
      id: 'p2',
      categoryId: 'c2',
      name: 'Masala Khakhra 200g',
      image: 'lib/assets/images/masala.png',
      price: 45.0),
  Product(
    id: 'p3',
    categoryId: 'c2',
    name: 'Jeera Khakhra 200g',
    image: 'lib/assets/images/Jerra Khkhra.webp',
    price: 45.0),
  Product(
    id: 'p4',
    categoryId: 'c2',
    name: 'Kothmir Marcha Khakhra 200g',
    image: 'lib/assets/images/Kothmir Marcha.jpg',
    price: 50.0),
  Product(
    id: 'p5',
    categoryId: 'c2',
    name: 'Manchurian Khakhra 200g',
    image: 'lib/assets/images/Manchurain Khakhra.jpg',
    price: 60.0),
  Product(
    id: 'p6',
    categoryId: 'c2',
    name: 'Masala Khakhra 200g',
    image: 'lib/assets/images/masla khakhra.webp',
    price: 48.0),
  Product(
    id: 'p7',
    categoryId: 'c2',
    name: 'Methi Khakhra 200g',
    image: 'lib/assets/images/Methi Khakhra.webp',
    price: 50.0),
  Product(
    id: 'p8',
    categoryId: 'c2',
    name: 'Palak Khakhra 200g',
    image: 'lib/assets/images/palak.jpg',
    price: 50.0),
  Product(
    id: 'p9',
    categoryId: 'c2',
    name: 'Pani Puri Khakhra 200g',
    image: 'lib/assets/images/pani puri.jpg',
    price: 55.0),
  Product(
    id: 'p10',
    categoryId: 'c2',
    name: 'Peri Peri Khakhra 200g',
    image: 'lib/assets/images/Peri Peri Khakhra.jpg',
    price: 55.0),
  Product(
    id: 'p11',
    categoryId: 'c2',
    name: 'Pizza Khakhra 200g',
    image: 'lib/assets/images/Pizza Khakhra.jpg',
    price: 60.0),
  Product(
    id: 'p12',
    categoryId: 'c1',
    name: 'Plain Khakhra (Jumbo) 400g',
    image: 'lib/assets/images/Plain khakhra.jpg',
    price: 70.0),
];
