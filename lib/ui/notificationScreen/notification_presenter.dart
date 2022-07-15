import 'package:flutter/cupertino.dart';
import 'package:krc/ui/api/api_controller_expo.dart';
import 'package:krc/ui/api/api_end_points.dart';
import 'package:krc/ui/api/api_error_parser.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/document/model/document_response.dart';
import 'package:krc/ui/notificationScreen/model/notification_response.dart';
import 'package:krc/ui/notificationScreen/notification_view.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

class NotificationPresenter extends BasePresenter {
  NotificationView _profileView;

  NotificationPresenter(this._profileView) : super(_profileView);

  void getBookingList(BuildContext context) async {
    //check network
    if (!await NetworkCheck.check()) return;

    String accountId = (await AuthUser().getCurrentUser()).userCredentials.accountId;

    // var body = {"AccountID": accountId};
    var body = {"AccountId": "0013C00000edzftQAA"};

    Dialogs.showLoader(context, "Getting Notifications ...");
    apiController.post(EndPoints.GET_NOTIFICATIONS, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        NotificationResponse bookingResponse = NotificationResponse.fromJson(response.data);
        if (bookingResponse.returnCode) {
          _profileView.onNotificationListFetched(bookingResponse);
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
