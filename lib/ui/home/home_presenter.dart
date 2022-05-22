import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/ui/api/api_controller_expo.dart';
import 'package:krc/ui/api/api_end_points.dart';
import 'package:krc/ui/api/api_error_parser.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/home/model/project_detail_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

import 'home_view.dart';

class HomePresenter extends BasePresenter {
  HomeView _v;

  HomePresenter(this._v) : super(_v);

  void getProjectDetail(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String accountId = (await AuthUser().getCurrentUser()).userCredentials.accountId;
    var body = {"AccountID": accountId};

    Dialogs.showLoader(context, "Getting project detail ...");
    apiController.post(EndPoints.GET_PROJECT_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProjectDetailResponse projectDetailResponse = ProjectDetailResponse.fromJson(response.data);
        if (projectDetailResponse.returnCode) {
          _v.onProjectDetailFetched(projectDetailResponse);
        } else {
          _v.onError(projectDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

}