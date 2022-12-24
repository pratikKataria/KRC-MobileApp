import 'package:dio/dio.dart';
import 'package:krc/api/api_controller_expo.dart';
import 'package:krc/api/api_end_points.dart';
import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/core/login/login_view.dart';
import 'package:krc/ui/env/environment_values.dart';
import 'package:krc/ui/home/home_view.dart';
import 'package:krc/user/token_response.dart';
import 'package:krc/utils/NetworkCheck.dart';

class BasePresenter {
  var tag = "BasePresenter";
  BaseView _v;

  BasePresenter(this._v);

  void getAccessToken() async {
    if (!await NetworkCheck.check()) {
      _v.onError("No Network Found");
      return;
    }

    var bodyReq = EnvironmentValues.getTokenBody();

    var body = FormData.fromMap(bodyReq);
    apiController.post(EndPoints.ACCESS_TOKEN, body: body)
      ..then((response) {
        TokenResponse tokenResponse = TokenResponse.fromJson(response.data);

        if (_v is LoginView) {
          LoginView loginView = _v as LoginView;
          loginView.onTokenGenerated(tokenResponse);
        }

        if (_v is HomeView) {
          HomeView loginView = _v as HomeView;
          loginView.onTokenRegenerated(tokenResponse);
        }

        /* else if (_v is TermsAndConditionView) {
          TermsAndConditionView loginView = _v as TermsAndConditionView;
          loginView.onTokenGenerated(tokenResponse);
        }*/
      })
      ..catchError((e) {});
  }
}
