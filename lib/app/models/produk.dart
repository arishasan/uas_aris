class Produk {

  int id;
  String title;
  double price;
  String category;
  String desc;
  String image;

  Produk({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.desc,
    required this.image
  });

}

List<Produk> globalProduk = [];