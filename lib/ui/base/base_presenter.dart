import 'package:dio/dio.dart';
import 'package:krc/ui/api/api_controller_expo.dart';
import 'package:krc/ui/api/api_end_points.dart';
import 'package:krc/ui/base/base_view.dart';
import 'package:krc/ui/core/login/login_view.dart';
import 'package:krc/ui/env/environment_values.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
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
        //Save token
        var currentUser = CurrentUser()..tokenResponse = tokenResponse;
        AuthUser.getInstance().saveToken(currentUser);

        if (_v is LoginView) {
          LoginView loginView = _v as LoginView;
          loginView.onTokenGenerated(tokenResponse);
        }

        /* else if (_v is TermsAndConditionView) {
          TermsAndConditionView loginView = _v as TermsAndConditionView;
          loginView.onTokenGenerated(tokenResponse);
        }*/
      })
      ..catchError((e) {});
  }
}
