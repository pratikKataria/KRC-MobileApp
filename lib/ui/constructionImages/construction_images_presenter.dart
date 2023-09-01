import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/constructionImages/construction_image_view.dart';
import 'package:krc/ui/constructionImages/model/construction_image_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';


class ConstructionImagePresenter extends BasePresenter {
  ConstructionImageView _v;

  ConstructionImagePresenter(this._v) : super(_v);

  void getConstructionImages(BuildContext context) async {
    //check for internal token
     

    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    var body = {
      "AccountId": accountId,
      "towerId": currentBookingDetailController.value?.towerId??"",
    };

    Dialogs.showLoader(context, "Getting construction images ...");
    apiController.post(EndPoints.GET_CONSTRUCTION_IMAGES, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        ConstructionImageResponse constructionImageResponse = ConstructionImageResponse.fromJson(response.data);
        // if (constructionImageResponse.returnCode) {
        _v.onConstructionImagesFetched(constructionImageResponse);
        // } else {
        //   _v.onError(constructionImageResponse.message);
        // }
        return;
      })
      ..catchError((e) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

}