class Groceries {
  final String image;
  final String name;
  final double rate;
  final int review;
  final String description;
  final double price;
  
  
  Groceries({
    required this.image,
    required this.name,
    required this.rate,
    required this.review,
    required this.description,
    required this.price,
  });
}

class OrderHistory {
  final Groceries product;
  final DateTime orderDate;

  OrderHistory({
    required this.product,
    required this.orderDate,
  });
}

final listGridGroceries = [
  Groceries(
    image: 'assets/jeruk.png',
    name: 'Jeruk',
    rate: 4.8,
    review: 130,
    description:
        'Jeruk merupakan sebuah buah yang memiliki khasiat. Jeruk yang merupakan buah sitrus memiliki banyak kandungan vitamin C dan anti oksidan, yang meningkatkan sistem kekebalan tubuh dan membantu melawan infeksi dan flu.',
    price: 4.53,
  ),
  Groceries(
    image: 'assets/apel.png',
    name: 'Apel',
    rate: 4.8,
    review: 330,
    description:
        'Apel mengandung senyawa antioksidan seperti lutein dan zeaxanthin, yang penting untuk menjaga kesehatan mata. Konsumsi apel secara teratur dapat membantu mengurangi risiko masalah mata, seperti degenerasi makula terkait usia.',
    price: 3.53,
  ),
  Groceries(
    image: 'assets/alpukat.png',
    name: 'Alpukat',
    rate: 4.8,
    review: 430,
    description:
        'Alpukat memiliki serat dan lemak yang baik, buah alpukat juga kaya akan kandungan kaliumnya. Jenis mineral satu ini sangat bermanfaat untuk membantu mengendalikan tekanan darah dan mencegah terjadinya tekanan darah tinggi. Tak hanya itu, kalium juga sangat baik untuk membantu mengatur detak jantung agar tetap normal.',
    price: 7.53,
  ),
  Groceries(
    image: 'assets/pisang.png',
    name: 'Pisang',
    rate: 4.8,
    review: 530,
    description:
        'Pisang memiliki kandungan potasium yang tinggi, sebuah mineral yang sangat penting untuk menjaga fungsi jantung dan sirkulasi darah. Karena alasan ini, sirkulasi oksigen ke otak dapat dijaga dengan baik, dan risiko stroke akibat tekanan darah tinggi dapat dicegah.',
    price: 5.53,
  ),
  Groceries(
    image: 'assets/jagung.png',
    name: 'Jagung',
    rate: 4.5,
    review: 630,
    description:
        'Jagung memiliki banyak manfaat bagi tubuh karena kandungan nutrisinya, diantara manfaatnya yaitu dapat menurunkan hipertensi sehingga dapat mencegah penyakit jantung.',
    price: 8.40,
  ),
  Groceries(
    image: 'assets/manggis.png',
    name: 'Manggis',
    rate: 4.9,
    review: 730,
    description:
        'Manggis memeiliki Kandungan antioksidan dalam manggis membantu melindungi kulit dari kerusakan akibat sinar matahari dan penuaan dini. Menurunkan Risiko Diabetes: Beberapa penelitian menunjukkan bahwa ekstrak manggis dapat membantu menurunkan kadar gula darah dan meningkatkan sensitivitas insulin.',
    price: 9.33,
  ),
];
