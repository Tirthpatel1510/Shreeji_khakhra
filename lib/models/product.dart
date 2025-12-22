class Product {
  final String id;
  final String categoryId;
  final String name;
  final String image;
  final double price;
  final String description; // ✅ NEW

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.price,
    required this.description, // ✅ NEW
  });
}

// ================= SAMPLE PRODUCTS =================

final sampleProducts = [
  Product(
    id: 'p1',
    categoryId: 'c1',
    name: 'Plain Khakhra 200g',
    image: 'lib/assets/images/plain.png',
    price: 40.0,
    description:
        'A simple whole wheat khakhra with a clean, homely taste and no strong spices. Light, crispy and perfect with pickles, chutneys or butter.',
  ),
  Product(
    id: 'p2',
    categoryId: 'c2',
    name: 'Masala Khakhra 200g',
    image: 'lib/assets/images/masala.png',
    price: 45.0,
    description:
        'A bold, chatpata khakhra loaded with Indian spices that delivers a street-style masala kick. Roasted with minimal oil for healthy snacking.',
  ),
  Product(
    id: 'p3',
    categoryId: 'c2',
    name: 'Jeera Khakhra 200g',
    image: 'lib/assets/images/Jerra Khkhra.webp',
    price: 45.0,
    description:
        'A classic cumin-flavoured khakhra with roasted jeera for a warm aroma and light-on-the-stomach feel. Perfect with tea or curd.',
  ),
  Product(
    id: 'p4',
    categoryId: 'c2',
    name: 'Kothmir Marcha Khakhra 200g',
    image: 'lib/assets/images/Kothmir Marcha.jpg',
    price: 50.0,
    description:
        'A zesty khakhra made with fresh coriander and green chillies, offering a mildly spicy and herby flavour for anytime snacking.',
  ),
  Product(
    id: 'p5',
    categoryId: 'c2',
    name: 'Manchurian Khakhra 200g',
    image: 'lib/assets/images/Manchurain Khakhra.jpg',
    price: 60.0,
    description:
        'An Indo-Chinese inspired khakhra with Manchurian-style spices, delivering a bold and tangy flavour in a crispy roasted form.',
  ),
  Product(
    id: 'p6',
    categoryId: 'c2',
    name: 'Masala Khakhra 200g',
    image: 'lib/assets/images/masla khakhra.webp',
    price: 48.0,
    description:
        'A flavour-packed masala khakhra roasted to perfection, offering a crunchy texture and spicy taste without being oily.',
  ),
  Product(
    id: 'p7',
    categoryId: 'c2',
    name: 'Methi Khakhra 200g',
    image: 'lib/assets/images/Methi Khakhra.webp',
    price: 50.0,
    description:
        'A wholesome khakhra enriched with aromatic methi leaves, known for aiding digestion and offering a mildly bitter, earthy taste.',
  ),
  Product(
    id: 'p8',
    categoryId: 'c2',
    name: 'Palak Khakhra 200g',
    image: 'lib/assets/images/palak.jpg',
    price: 50.0,
    description:
        'A nutritious spinach-based khakhra that adds natural green colour and subtle flavour, making daily snacking healthier.',
  ),
  Product(
    id: 'p9',
    categoryId: 'c2',
    name: 'Pani Puri Khakhra 200g',
    image: 'lib/assets/images/pani puri.jpg',
    price: 55.0,
    description:
        'A fun, tangy khakhra inspired by pani puri flavours, offering a chatpata taste loved by kids and adults alike.',
  ),
  Product(
    id: 'p10',
    categoryId: 'c2',
    name: 'Peri Peri Khakhra 200g',
    image: 'lib/assets/images/Peri Peri Khakhra.jpg',
    price: 55.0,
    description:
        'A fiery peri-peri flavoured khakhra for spice lovers, delivering bold taste while remaining light and roasted.',
  ),
  Product(
    id: 'p11',
    categoryId: 'c2',
    name: 'Pizza Khakhra 200g',
    image: 'lib/assets/images/Pizza Khakhra.jpg',
    price: 60.0,
    description:
        'A pizza-inspired khakhra with cheesy and herby notes, making it a fun fusion snack for parties and tiffins.',
  ),
  Product(
    id: 'p12',
    categoryId: 'c1',
    name: 'Plain Khakhra (Jumbo) 400g',
    image: 'lib/assets/images/Plain khakhra.jpg',
    price: 70.0,
    description:
        'A jumbo-sized plain khakhra with a clean wheat taste, ideal for families and versatile meal combinations.',
  ),
];
