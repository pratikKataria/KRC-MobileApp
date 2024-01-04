import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/bottomNavigation/home/model/rm_detail_response.dart';
import 'package:krc/ui/rmDetail/contact_us_view.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

class ContactUsPresenter extends BasePresenter {
  ContactUsView _v;

  ContactUsPresenter(this._v) : super(_v);

  void getRMDetails(BuildContext context) async {
    //check for internal token
     

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = "0013C00000rWwiDQAS";
        // (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"AccountID": accountId??"0013C00000edzftQAA"};

    // Dialogs.showLoader(context, "Getting your rm details ...");
    apiController.post(EndPoints.GET_RM_DETAILS, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader();
        RmDetailResponse rmDetailResponse = RmDetailResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode!) {
          _v.onRmDetailFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }
}
