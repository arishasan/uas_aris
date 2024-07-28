import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uas_aris/app/models/global.dart';
import 'package:uas_aris/config/const_vars.dart';
import '/config/decoders.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* ApiService
| -------------------------------------------------------------------------
| Define your API endpoints
| Learn more https://nylo.dev/docs/5.20.0/networking
|-------------------------------------------------------------------------- */

class ApiService extends NyApiService {

  ApiService({BuildContext? buildContext}) : super(
      buildContext,
      decoders: modelDecoders,
      // baseOptions: (BaseOptions baseOptions) {
      //   return baseOptions
      //             ..connectTimeout = Duration(seconds: 5)
      //             ..sendTimeout = Duration(seconds: 5)
      //             ..receiveTimeout = Duration(seconds: 5);
      // },
  );

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  @override
  // ignore: overridden_fields
  final interceptors = {
    if (getEnv('APP_DEBUG') == true)
    PrettyDioLogger: PrettyDioLogger()
  };

  Future fetchTestData() async {
    return await network(
        request: (request) => request.get("/endpoint-path"),
    );
  }

  Future<List<Notif>> methodLogin(dynamic data) async {

    try {

      // String token = globalToken;

      print(data);

      listNotif.clear();

      // withFile ? 'multipart/form-data' :
      var response = await Dio().post(
        baseUrl + "/auth/login",
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      Map<String, dynamic> decodedMap = Map<String, dynamic>.from(response.data);
      print(response.data);

      if(response.data.toString().contains("token")){
        Map<String, dynamic> ret = response.data;
        listNotif.add(
          Notif(error: false, message: "Berhasil login", data: ret['token'], meta: [])
        );
      }else{
        listNotif.add(
          Notif(error: true, message: "Username atau password salah.", data: data, meta: [])
        );
      }

      return listNotif;
      
      // listNotif.add(Notif(error: (decodedMap['success'] ? false : true), message: decodedMap['message'] ?? '', data: {
      //   "admin_token" : decodedMap['admin_token'],
      //   "admin_refresh_token" : decodedMap['admin_refresh_token'],
      //   "admin_refresh_token_expired" : decodedMap['admin_refresh_token_expired'],
      // }, meta: decodedMap['meta'] ?? []));

      // return listNotif;

    } on DioException catch (e) {
      // String error = '';
      // if (e.response != null) {
      //   print(e.response!.data);
      //   Map<String, dynamic> decodedMap = Map<String, dynamic>.from(e.response!.data);
      //   error = decodedMap['message'] ?? '';
      // } else {
      //   print(e.requestOptions);
      //   print(e.message);
      //   error = e.message.toString();
      // }

      listNotif.add(Notif(error: true, message: e.message.toString(), data: [], meta: []));
      return listNotif;
    }

  }

  Future<List<Notif>> methodPOST(dynamic data, String url) async {

    try {

      String token = globalToken;

      listNotif.clear();

      // withFile ? 'multipart/form-data' :
      var response = await Dio().post(
        baseUrl + url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: data
      );

      // Map<String, dynamic> decodedMap = Map<String, dynamic>.from(response.data);
      print(response.data);
      
      listNotif.add(Notif(error: true, message: "", data: "", meta: []));

      return listNotif;

    } on DioException catch (e) {
      // String error = '';
      // if (e.response != null) {
      //   print(e.response!.data);
      //   Map<String, dynamic> decodedMap = Map<String, dynamic>.from(e.response!.data);
      //   error = decodedMap['message'] ?? '';
      // } else {
      //   print(e.requestOptions);
      //   print(e.message);
      //   error = e.message.toString();
      // }

      // listNotif.add(Notif(error: true, message: error, data: [], meta: []));
      // return listNotif;

      listNotif.add(Notif(error: true, message: e.message.toString(), data: [], meta: []));
      return listNotif;
    }

  }

  Future<List<Notif>> methodPUT(dynamic data, bool withFile, String url, isAkses) async {

    try {

      String token = globalToken;

      listNotif.clear();

      if(withFile){

      }

      var response = await Dio().put(
        baseUrl + url,
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
            'x-access-token': token
          },
        ),
        data: data
      );

      Map<String, dynamic> decodedMap = Map<String, dynamic>.from(response.data);
      print(response.data);
      
      listNotif.add(Notif(error: (decodedMap['success'] ? false : true), message: decodedMap['message'] ?? '', data: decodedMap['data'], meta: decodedMap['meta'] ?? []));

      return listNotif;

    } on DioException catch (e) {
      String error = '';
      if (e.response != null) {
        print(e.response!.data);
        Map<String, dynamic> decodedMap = Map<String, dynamic>.from(e.response!.data);
        error = decodedMap['message'] ?? '';
      } else {
        print(e.requestOptions);
        print(e.message);
        error = e.message.toString();
      }

      listNotif.add(Notif(error: true, message: error, data: [], meta: []));
      return listNotif;
    }

  }

  Future<List<Notif>> methodDELETE(dynamic data, String url, isAkses) async {

    try {

      String token = globalToken;

      listNotif.clear();

      var response = await Dio().delete(
        baseUrl + url,
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
            'x-access-token': token
          },
        ),
        data: data
      );

      Map<String, dynamic> decodedMap = Map<String, dynamic>.from(response.data);
      print(response.data);
      
      listNotif.add(Notif(error: (decodedMap['success'] ? false : true), message: decodedMap['message'] ?? '', data: decodedMap['data'], meta: decodedMap['meta'] ?? []));

      return listNotif;

    } on DioException catch (e) {
      String error = '';
      if (e.response != null) {
        print(e.response!.data);
        Map<String, dynamic> decodedMap = Map<String, dynamic>.from(e.response!.data);
        error = decodedMap['message'] ?? '';
      } else {
        print(e.requestOptions);
        print(e.message);
        error = e.message.toString();
      }

      listNotif.add(Notif(error: true, message: error, data: [], meta: []));
      return listNotif;
    }

  }

  Future<List<Notif>> methodGET(String url) async {

    try {

      String token = globalToken;

      listNotif.clear();

      var response = await Dio().get(
        baseUrl + url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Map<String, dynamic> decodedMap = Map<String, dynamic>.from(response.data);
      print(response.data);
      
      listNotif.add(Notif(error: response.statusCode == 200 ? false : true, message: "Get data success", data: response.data, meta: []));
      return listNotif;

    } on DioException catch (e) {
      listNotif.add(Notif(error: true, message: e.message.toString(), data: [], meta: []));
      return listNotif;
    }

  }

  /* Helpers
  |-------------------------------------------------------------------------- */


  /* Authentication Headers
  |--------------------------------------------------------------------------
  | Set your auth headers
  | Authenticate your API requests using a bearer token or any other method
  |-------------------------------------------------------------------------- */

  // @override
  // Future<RequestHeaders> setAuthHeaders(RequestHeaders headers) async {
  //   String? myAuthToken = await StorageKey.userToken.read();
  //   if (myAuthToken != null) {
  //     headers.addBearerToken( myAuthToken );
  //   }
  //   return headers;
  // }


  /* Should Refresh Token
  |--------------------------------------------------------------------------
  | Check if your Token should be refreshed
  | Set `false` if your API does not require a token refresh
  |-------------------------------------------------------------------------- */

  // @override
  // Future<bool> shouldRefreshToken() async {
  //   return false;
  // }


  /* Refresh Token
  |--------------------------------------------------------------------------
  | If `shouldRefreshToken` returns true then this method
  | will be called to refresh your token. Save your new token to
  | local storage and then use the value in `setAuthHeaders`.
  |-------------------------------------------------------------------------- */

  // @override
  // refreshToken(Dio dio) async {
  //  dynamic response = (await dio.get("https://example.com/refresh-token")).data;
  //  // Save the new token
  //   await StorageKey.userToken.store(response['token']);
  // }


  /* Display a error
  |--------------------------------------------------------------------------
  | This method is only called if you provide the API service
  | with a [BuildContext]. Example below:
  | api<ApiService>(
  |        request: (request) => request.myApiCall(),
  |         context: context);
  |-------------------------------------------------------------------------- */

  // displayError(DioException dioException, BuildContext context) {
  //   showToastNotification(context,
  //       title: "Error",
  //       description: dioException.message ?? "",
  //       style: ToastNotificationStyleType.DANGER);
  // }
}