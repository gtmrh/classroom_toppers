import 'package:dio/dio.dart';
import 'package:classroom_toppers/utils/log_util.dart';

import '../../utils/sharedpref.dart';
import 'custom_log_interceptor.dart';

// final title = "ApiUtils";

ApiUtils apiUtils = ApiUtils();

class ApiUtils {
  static ApiUtils _apiUtils = ApiUtils._i();
  final Dio _dio = Dio();

  ApiUtils._i() {
    _dio.interceptors.add(CustomLogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    ));
  }

  factory ApiUtils() {
    return _apiUtils;
  }

  Map<String, String> header = {"Content-Type": "application/json"};

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "api-version": "1"
  };

  Map<String, String> secureHeaders = {
    "Content-Type": "application/json",
    "api-version": "1",
    "Authorization": ""
  };

  // Future<Response> get({
  //   required String url,
  //   Map<String, dynamic>? queryParameters,
  // }) async {
  //   var token = await SharedPref().getToken();

  //   var result = await _dio.get(
  //     url,
  //     queryParameters: queryParameters,
  //     options: Options(
  //         receiveTimeout: Duration(seconds: 8).inMilliseconds,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         }),
  //   );
  //   return result;
  // }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = await SharedPref().getToken();

    int maxRetries = 3;
    int currentRetry = 0;
    int retryDelayInSeconds = 2;

    Response? response;

    do {
      try {
        response = await _dio.get(
          url,
          queryParameters: queryParameters,
          options: Options(
            receiveTimeout: Duration(seconds: 3),
            sendTimeout: Duration(seconds: 3),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );
        // Successful response, no need to retry
        break;
      } catch (e) {
        if (e is DioError) {
          if (e.response?.statusCode == 429 && currentRetry < maxRetries) {
            // Retry with increasing backoff delay
            await Future.delayed(Duration(seconds: retryDelayInSeconds));
            retryDelayInSeconds *= 2; // Double the delay for each retry
            currentRetry++;
            print('Retrying request (${currentRetry}/${maxRetries})');
            continue; // Retry the request
          }
          throw e; // Rethrow other DioError cases or max retry reached
        }
      }
    } while (currentRetry <= maxRetries);

    if (response != null) {
      return response; // Return the successful response
    } else {
      throw DioError(
          requestOptions: RequestOptions(path: url)); // Handle failure
    }
  }

//   Future<Response> post({
//   required String url,
//   data,
//   Map<String, dynamic>? queryParameters,
// }) async {
//   var token = await SharedPref().getToken();

//   int maxRetries = 3;
//   int currentRetry = 0;
//   int retryDelayInSeconds = 2;

//   Response? response;

//   do {
//     try {
//       response = await _dio.post(
//         url,
//         data: data,
//         queryParameters: queryParameters,
//         options: Options(
//           receiveTimeout: Duration(seconds: 8).inMilliseconds,
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );
//       // Successful response, no need to retry
//       break;
//     } catch (e) {
//       if (e is DioError) {
//         if (e.response?.statusCode == 429 && currentRetry < maxRetries) {
//           // Retry with increasing backoff delay
//           await Future.delayed(Duration(seconds: retryDelayInSeconds));
//           retryDelayInSeconds *= 2; // Double the delay for each retry
//           currentRetry++;
//           print('Retrying request (${currentRetry}/${maxRetries})');
//           continue; // Retry the request
//         }
//         throw e; // Rethrow other DioError cases or max retry reached
//       }
//     }
//   } while (currentRetry <= maxRetries);

//   if (response != null) {
//     return response; // Return the successful response
//   } else {
//     throw DioError(
//           requestOptions: RequestOptions(path: url)); // Handle failure
//     }
// }

  Future<Response> post({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = await SharedPref().getToken();

    var result = await _dio.post(url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            receiveTimeout: Duration(seconds: 3),
            sendTimeout: Duration(seconds: 3),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            }));

    return result;
  }

  Future<Response> postWithProgress({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    //
    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
    );
    return result;
  }

  Future<Response> put({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  Future<Response> delete({
    required String api,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Options options = Options(headers: secureHeaders);

    //var result = await _dio.delete(api, options: options);
    var result = await _dio.delete(
      api,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  String handleError(dynamic error) {
    String errorDescription = "";

    Log.loga(title, "handleError:: error >> $error");

    if (error is DioError) {
      Log.loga(
          title, '************************ DioError ************************');

      DioError dioError = error as DioError;
      Log.loga(title, 'dioError:: $dioError');
      if (dioError.response != null) {
        Log.loga(
            title, "dioError:: response >> " + dioError.response.toString());
      }

      switch (dioError.type) {
        case DioExceptionType.unknown:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioExceptionType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioExceptionType.badResponse:
          errorDescription =
              "Received invalid status code: ${dioError.response?.statusCode}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
        case DioExceptionType.badCertificate:
          errorDescription = "Send timeout in bad cerificate with API server";
          break;
        case DioExceptionType.connectionError:
          errorDescription = "Send timeout in connection error with API server";
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    Log.loga(title, "handleError:: errorDescription >> $errorDescription");
    return errorDescription;
  }

  getFormattedError() {
    return {'error': 'Error'};
  }

  getNetworkError() {
    return "No Internet Connection.";
  }
}
