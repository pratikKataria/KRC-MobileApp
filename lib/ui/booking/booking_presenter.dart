import 'package:flutter/cupertino.dart';
import 'package:krc/api/api_error_parser.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';

import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/booking/model/booking_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

import 'booking_view.dart';
import 'model/booking_detail_response.dart';

class BookingPresenter extends BasePresenter {
  BookingView _profileView;

  BookingPresenter(this._profileView) : super(_profileView);

  void getBookingList(BuildContext context, String bookingId) async {
    //check network
    if (!await NetworkCheck.check()) return;
    var body = {"bookingId":bookingId};
    Dialogs.showLoader(context, "Fetching Bookings ...");
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

  void getBookingDetails(BuildContext context, String? bookingId) async {
    //check network
    if (!await NetworkCheck.check()) return;
    var body = {"BookingID": bookingId};
    Dialogs.showLoader(context, "Fetching Bookings Details ...");
    apiController.post(EndPoints.GET_BOOKING_DETAILS, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        BookingDetailResponse bookingResponse = BookingDetailResponse.fromJson(response.data);
        if (bookingResponse.returnCode!) {
          _profileView.onBookingDetailFetched(bookingResponse);
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
