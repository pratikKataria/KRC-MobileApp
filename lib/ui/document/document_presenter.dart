import 'package:flutter/cupertino.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/document/model/document_response.dart';
 import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

import 'document_view.dart';
import 'model/booking_response.dart';

class DocumentPresenter extends BasePresenter {
  DocumentView _profileView;

  DocumentPresenter(this._profileView) : super(_profileView);

  void getBookingList(BuildContext context) async {
    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = "0013C00000rWwiDQAS";
        // (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    var body = {"BookingID": accountId};
    Dialogs.showLoader(context, "Getting documents ...");
    apiController.post(EndPoints.GET_BOOKING, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        BookingResponse bookingResponse = BookingResponse.fromJson(response.data);
        if (bookingResponse.returnCode!) {
          _profileView.onBookingListFetched(bookingResponse);
        } else {
          _profileView.onError(bookingResponse.message);
        }
      })
      ..catchError((error) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(error, _profileView);
      });
  }

  void getDocumentsList(BuildContext context, bookingId) async {
    //check network
    if (!await NetworkCheck.check()) return;

    var body = {"BookingID":bookingId};
    Dialogs.showLoader(context, "Getting documents ...");
    apiController.post(EndPoints.POST_DOCUMENT_CENTER, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        DocumentResponse bookingResponse = DocumentResponse.fromJson(response.data);
        if (bookingResponse.returnCode!) {
          _profileView.onDocumentsFileFetched(bookingResponse);
        } else {
          _profileView.onError(bookingResponse.message);
        }
      })
      ..catchError((error) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(error, _profileView);
      });
  }

}
