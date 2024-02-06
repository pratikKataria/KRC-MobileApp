import 'package:flutter/cupertino.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/demandScreen/model/demand_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

import 'demand_view.dart';

class DemandPresenter extends BasePresenter {
  DemandView _profileView;

  DemandPresenter(this._profileView) : super(_profileView);

  void getDemandList(BuildContext context, String bookingId) async {
    //check network
    if (!await NetworkCheck.check()) return;

    var body = {
      "bookingId": bookingId
      // currentBookingDetailController.value?.bookingId
    };

    Dialogs.showLoader(context, "Fetching Demands ...");
    apiController.post(EndPoints.GET_DEMANDS, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        DemandResponse receiptResponse = DemandResponse.fromJson(response.data);
        if (receiptResponse.returnCode!) {
          _profileView.onDemandListFetched(receiptResponse);
        } else {
          if (receiptResponse.message != 'No Invoice available against customer') _profileView.onError(receiptResponse.message);
        }
      })
      ..catchError((error) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(error, _profileView);
      });
  }
}
