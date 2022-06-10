import 'package:flutter/cupertino.dart';
import 'package:krc/ui/api/api_controller_expo.dart';
import 'package:krc/ui/api/api_end_points.dart';
import 'package:krc/ui/api/api_error_parser.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/booking/model/booking_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

import 'booking_view.dart';

class BookingPresenter extends BasePresenter {
  BookingView _profileView;

  BookingPresenter(this._profileView) : super(_profileView);

  void getBookingList(BuildContext context) async {
    //check network
    if (!await NetworkCheck.check()) return;

    String accountId = (await AuthUser().getCurrentUser()).userCredentials.accountId;

    var body = {"AccountID": accountId};
    Dialogs.showLoader(context, "Getting Bookings ...");
    apiController.post(EndPoints.GET_BOOKING, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        BookingResponse bookingResponse = BookingResponse.fromJson(response.data);
        if (bookingResponse.returnCode) {
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
}
