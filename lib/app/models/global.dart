class Notif {
  late bool error;
  late String message;
  late dynamic data;
  late dynamic meta;
  
  Notif(
    {
      required this.error,
      required this.message,
      required this.data,
      required this.meta
    }
  );
}
List<Notif> listNotif = [];