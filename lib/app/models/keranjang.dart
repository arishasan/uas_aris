class HistoryKeranjang {

  int id;
  int user;
  DateTime date;
  List<dynamic> products;

  HistoryKeranjang({
    required this.id,
    required this.user,
    required this.date,
    required this.products,
  });

}

List<HistoryKeranjang> globalHistoryKeranjang = [];

class Keranjang {

  int idproduk;
  String namaProduk;
  double price;
  int qty;

  Keranjang({
    required this.idproduk,
    required this.namaProduk,
    required this.price,
    required this.qty
  });

}

List<Keranjang> globalKeranjang = [];