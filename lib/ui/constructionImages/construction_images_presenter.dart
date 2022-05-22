import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/ui/api/api_controller_expo.dart';
import 'package:krc/ui/api/api_end_points.dart';
import 'package:krc/ui/api/api_error_parser.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/constructionImages/construction_image_view.dart';
import 'package:krc/ui/constructionImages/model/construction_image_response.dart';
import 'package:krc/ui/home/model/project_detail_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';


class ConstructionImagePresenter extends BasePresenter {
  ConstructionImageView _v;

  ConstructionImagePresenter(this._v) : super(_v);

  void getConstructionImages(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    String accountId = (await AuthUser().getCurrentUser()).userCredentials.accountId;
    var body = {"AccountID": accountId};

    Dialogs.showLoader(context, "Getting construction images ...");
    apiController.post(EndPoints.GET_CONSTRUCTION_IMAGES, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ConstructionImageResponse constructionImageResponse = ConstructionImageResponse.fromJson(response.data);
        // if (constructionImageResponse.returnCode) {
          _v.onConstructionImagesFetched(constructionImageResponse);
        // } else {
        //   _v.onError(constructionImageResponse.message);
        // }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

}