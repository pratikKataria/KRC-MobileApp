import 'package:flutter/cupertino.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/receiptScreen/model/receipt_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

import 'receipt_view.dart';

class ReceiptPresenter extends BasePresenter {
  ReceiptView _profileView;

  ReceiptPresenter(this._profileView) : super(_profileView);

  void getReceiptList(BuildContext context) async {
    //check network
    if (!await NetworkCheck.check()) return;
    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    var body = {"bookingId": currentBookingDetailController.value?.bookingId};

    Dialogs.showLoader(context, "Getting receipts ...");
    apiController.post(EndPoints.GET_RECEIPTS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader();
        ReceiptResponse receiptResponse = ReceiptResponse.fromJson(response.data);
        if (receiptResponse.returnCode!) {
          _profileView.onReceiptListFetched(receiptResponse);
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
