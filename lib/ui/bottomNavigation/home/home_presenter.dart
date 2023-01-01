import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/bottomNavigation/home/model/project_detail_response.dart';
import 'package:krc/ui/bottomNavigation/home/model/rm_detail_response.dart';

import 'package:krc/ui/profile/model/profile_detail_response.dart';
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

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"AccountID": accountId};

    Dialogs.showLoader(context, "Getting project detail ...");
    apiController.post(EndPoints.GET_PROJECT_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProjectDetailResponse projectDetailResponse = ProjectDetailResponse.fromJson(response.data);
        if (projectDetailResponse.returnCode!) {
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

  void getProjectDetailS(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"AccountID": accountId};

    apiController.post(EndPoints.GET_PROJECT_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
        ProjectDetailResponse projectDetailResponse = ProjectDetailResponse.fromJson(response.data);
        if (projectDetailResponse.returnCode!) {
          _v.onProjectDetailFetched(projectDetailResponse);
        } else {
          _v.onError(projectDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getRMDetails(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"AccountID": accountId};

    apiController.post(EndPoints.GET_RM_DETAILS, body: body, headers: await Utility.header())
      ..then((response) {
        RmDetailResponse rmDetailResponse = RmDetailResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode!) {
          _v.onRmDetailFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  Future<void> getProfileDetailsNoLoader(BuildContext context) async {
    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    var body = {"AccountID": accountId};
    apiController.post(EndPoints.GET_PROFILE_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
        ProfileDetailResponse profileDetailResponse = ProfileDetailResponse.fromJson(response.data);
        if (profileDetailResponse.returnCode!) {
          _v.onProfileDetailsFetched(profileDetailResponse);
        } else {
          _v.onError(profileDetailResponse.message);
        }
      })
      ..catchError((error) {
        ApiErrorParser.getResult(error, _v);
      });
  }
}
