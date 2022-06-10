import 'package:flutter/cupertino.dart';
import 'package:krc/ui/api/api_controller_expo.dart';
import 'package:krc/ui/api/api_end_points.dart';
import 'package:krc/ui/api/api_error_parser.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/demandScreen/model/demand_response.dart';
import 'package:krc/ui/receiptScreen/model/receipt_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

import 'demand_view.dart';

class DemandPresenter extends BasePresenter {
  DemandView _profileView;

  DemandPresenter(this._profileView) : super(_profileView);

  void getDemandList(BuildContext context) async {
    //check network
    if (!await NetworkCheck.check()) return;
    String accountId = (await AuthUser().getCurrentUser()).userCredentials.accountId;

    var body = {"AccountID": "0013C00000eE49aQAC"};

    Dialogs.showLoader(context, "Getting demands ...");
    apiController.post(EndPoints.GET_DEMANDS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        DemandResponse receiptResponse = DemandResponse.fromJson(response.data);
        if (receiptResponse.returnCode) {
          _profileView.onDemandListFetched(receiptResponse);
        } else {
          _profileView.onError(receiptResponse.message);
        }
      })
      ..catchError((error) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(error, _profileView);
      });
  }
}
