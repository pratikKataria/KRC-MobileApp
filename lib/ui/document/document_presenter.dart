import 'package:flutter/cupertino.dart';
import 'package:krc/common_imports.dart';
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

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    var body = {"AccountID": accountId};
    Dialogs.showLoader(context, "Getting Bookings ...");
    apiController.post(EndPoints.GET_BOOKING, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        BookingResponse bookingResponse = BookingResponse.fromJson(response.data);
        if (bookingResponse.returnCode!) {
          _profileView.onBookingListFetched(bookingResponse);
        } else {
          _profileView.onError(bookingResponse.message);
        }
      })
      ..catchError((error) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(error, _profileView);
      });
  }

  void getDocumentsList(BuildContext context, String? bookingID) async {
    //check network
    if (!await NetworkCheck.check()) return;

    var body = {"BookingID": bookingID};
    Dialogs.showLoader(context, "Getting Bookings ...");
    apiController.post(EndPoints.POST_DOCUMENT_CENTER, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        DocumentResponse bookingResponse = DocumentResponse.fromJson(response.data);
        if (bookingResponse.returnCode!) {
          _profileView.onDocumentsFileFetched(bookingResponse);
        } else {
          _profileView.onError(bookingResponse.message);
        }
      })
      ..catchError((error) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(error, _profileView);
      });
  }

}
