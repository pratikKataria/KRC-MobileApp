import 'package:dio/dio.dart';
import 'package:krc/api/api_controller_expo.dart';
import 'package:krc/api/api_end_points.dart';
import 'package:krc/api/dio_http_client.dart';
import 'package:krc/env/environment_values.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/user/token_response.dart';

class TokenInterceptor extends Interceptor {
  String? _token;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String accessToken = await AuthUser.getInstance().token();
    options.headers['Authorization'] = '$accessToken';
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token is expired or invalid
      await _refreshToken();

      RequestOptions requestOptions = err.response!.requestOptions;
      String accessToken = await AuthUser.getInstance().token();
      requestOptions.headers['Authorization'] = '$accessToken';

      print(requestOptions.headers);
      DioSingleton().dio.interceptors.add(this);
      Response response = await DioSingleton().dio.request(requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          ));
      print("STatus code is : ${response.statusCode}");
      return handler.resolve(response);
    }
    return super.onError(err, handler);
  }

  Future<void> _refreshToken() async {
    // Call your API to refresh the token
    var bodyReq = EnvironmentValues.getTokenBody();
    var body = FormData.fromMap(bodyReq);
    apiController.post(EndPoints.ACCESS_TOKEN, body: body).then((response) async {
      print(response);
      TokenResponse tokenResponse = TokenResponse.fromJson(response.data);

      CurrentUser currentUser = (await AuthUser.getInstance().getCurrentUser()) ?? CurrentUser();

      //Save token
      currentUser.tokenResponse = tokenResponse;
      await AuthUser.getInstance().saveToken(currentUser);
    }).catchError((onError) {
      print(onError);
    });
  }
}

/*
import 'package:aeon_mobile_app/api/api_controller_expo.dart';
import 'package:aeon_mobile_app/api/end_points.dart';
import 'package:aeon_mobile_app/env/environment_variable.dart';
import 'package:aeon_mobile_app/ui/pincode_screen/model/pincode_response.dart';
import 'package:aeon_mobile_app/user/AuthUser.dart';
import 'package:aeon_mobile_app/user/CurrentUser.dart';
import 'package:aeon_mobile_app/user/token_response.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor(*/
/*{required this.accessToken}*/ /*
);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String accessToken = await AuthUser.getInstance().token();
    options.headers['Authorization'] = 'Bearer $accessToken';
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Handle token expiration
      // Refresh token and retry request
      RequestOptions options = err.response!.requestOptions;

      try {
        // Refresh token
        var bodyReq = EnvironmentVariables.getTokenBody();
        var body = FormData.fromMap(bodyReq);
        apiController.post<TokenResponse>(EndPoints.ACCESS_TOKEN, body: body)
          ..then((TokenResponse tokenResponse) async {
            // Save new token to secure storage
            var currentUser = CurrentUser()..tokenResponse = tokenResponse;
            await AuthUser.getInstance().saveToken(currentUser);

            // Retry request
            apiController.post<Response>(EndPoints.PINCODE, body: body)
            ..then((Response response)  {
              super.onResponse(response, ResponseInterceptorHandler());
            })
            ..catchError((onError) {
              super.onError(err, handler);
            });
          })
          ..catchError((onError) {
            super.onError(err, handler);
          });

        // handler.resolve(Response(data: response.toJson(), requestOptions: options));
        return;
      } catch (e) {
        handler.reject(e as DioError);
        return;
      } finally {
        // apiController.dio.interceptors.requestLock.unlock();
        // apiController.dio.interceptors.responseLock.unlock();
      }
    }

    if (err.response?.statusCode == 200) {
      return super.onResponse(err.response!, ResponseInterceptorHandler());
    }
    return super.onError(err, handler);
  }
}
*/
