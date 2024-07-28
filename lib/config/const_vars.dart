import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';

// Color.fromARGB(255, 227, 0, 22);
Color colorUtama = Color.fromARGB(255, 29, 176, 246);
Color colorKedua = Color.fromARGB(255, 46, 50, 63);
Color colorKetiga = Color.fromARGB(255, 34, 74, 41);
Color colorGrey = Color.fromARGB(255, 214, 209, 202);

String globalDevelopmentVersion = getEnv('APP_ENV');
String globalVersion = "1.0";
String globalBuildVersion = "1";

TextStyle kBillTextStyle = GoogleFonts.poppins(
  color: colorUtama,
  fontSize: 15.0,
);

int globalIDUser = 0;
String globalNamaUser = 'Nama User';
// String globalIDUser = '';
String globalEmailUser = '';
String globalPhotoUser = '';
String globalGroupUser = '';

int globalIndex = 0;

String globalScreen = 'PRODUK';
int globalSelectedItemIDX = 0;

double globalLatitude = -2.9932642;
double globalLongitude = 117.8420451;

String globalToken = '';

String msgErrorGlobal = "Terjadi kesalahan, silahkan ulangi lagi. Atau hubungi admin.";