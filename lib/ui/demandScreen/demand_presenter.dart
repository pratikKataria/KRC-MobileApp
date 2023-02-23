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

  void getDemandList(BuildContext context) async {
    //check network
    if (!await NetworkCheck.check()) return;

    var body = {"bookingId": currentBookingDetailController.value?.bookingId};

    Dialogs.showLoader(context, "Getting demands ...");
    apiController.post(EndPoints.GET_DEMANDS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader();
        DemandResponse receiptResponse = DemandResponse.fromJson(response.data);
        if (receiptResponse.returnCode!) {
          _profileView.onDemandListFetched(receiptResponse);
        } else {
          _profileView.onError(receiptResponse.message);
        }
      })
      ..catchError((error) {
        Dialogs.hideLoader();
        ApiErrorParser.getResult(error, _profileView);
      });
  }
}
