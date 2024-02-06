import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/bottomNavigation/home/model/booking_list_response.dart';
import 'package:krc/ui/bottomNavigation/home/model/project_detail_response.dart';
import 'package:krc/ui/bottomNavigation/home/model/rm_detail_response.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

import 'home_view.dart';
import 'model/device_token_response.dart';

class HomePresenter extends BasePresenter {
  HomeView _v;

  HomePresenter(this._v) : super(_v);

  void getBookingList(BuildContext context) async {
    //check for internal token
     

    //check network
    if (!await NetworkCheck.check()) return;

    List<String>? bookingIds = (await AuthUser().getCurrentUser())!.userCredentials!.bookingIds;
    var body = {"bookingIds": bookingIds};

    Dialogs.showLoader(context, "Fetching Booking details ...");
    apiController.post(EndPoints.GET_BOOKING_LIST, body: body, headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        BookingListResponse projectDetailResponse = BookingListResponse.fromJson(response.data);
        if (projectDetailResponse.returnCode!) {
          _v.onBookingListFetched(projectDetailResponse);
        } else {
          _v.onError(projectDetailResponse.message);
        }
        return;
      })
      ..catchError((e) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getBookingListNoLoader(BuildContext context) async {
    //check for internal token
     

    //check network
    if (!await NetworkCheck.check()) return;

    List<String>? bookingIds = (await AuthUser().getCurrentUser())!.userCredentials!.bookingIds;
    var body = {"bookingIds": bookingIds};

    // Dialogs.showLoader(context, "Fetching Booking details ...");
    apiController.post(EndPoints.GET_BOOKING_LIST, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader();
        BookingListResponse projectDetailResponse = BookingListResponse.fromJson(response.data);
        if (projectDetailResponse.returnCode!) {
          _v.onBookingListFetched(projectDetailResponse);
        } else {
          _v.onError(projectDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getBookingListWithoutLoader(BuildContext context) async {
    //check for internal token
     

    //check network
    if (!await NetworkCheck.check()) return;

    List<String>? bookingIds = (await AuthUser().getCurrentUser())!.userCredentials!.bookingIds;
    var body = {"bookingIds": bookingIds};

    // Dialogs.showLoader(context, "Fetching Booking details ...");
    apiController.post(EndPoints.GET_BOOKING_LIST, body: body, headers: await Utility.header())
      ..then((response) {
        // Dialogs.hideLoader(context);
        BookingListResponse projectDetailResponse = BookingListResponse.fromJson(response.data);
        if (projectDetailResponse.returnCode!) {
          _v.onBookingListFetched(projectDetailResponse);
        } else {
          _v.onError(projectDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        // Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

  void postDeviceToken(BuildContext context) async {
     

    //check network
    if (!await NetworkCheck.check()) {
      _v.onError("Network Error");
      return;
    }

    String? deviceToken = await FirebaseMessaging.instance.getToken();
    String? accountId = "0013C00000rWwiDQAS";
        // (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    var body = {
      "AccountID": "$accountId",
      "deviceToken": "$deviceToken",
    };
    Utility.log(tag, "Device Token: $deviceToken");

    apiController.post(EndPoints.POST_DEVICE_TOKEN, body: body, headers: await Utility.header())
      ..then((response) async {
        DeviceTokenResponse deviceTokenResponse = DeviceTokenResponse.fromJson(response.data);
        Utility.log(tag, "Device Token: ${deviceTokenResponse?.token}");
      })
      ..catchError((e) async {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getProjectDetailS(BuildContext context, String bookingId) async {
    //check for internal token
     

    //check network
    if (!await NetworkCheck.check()) return;
        // (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"bookingId": bookingId};

    apiController.post(EndPoints.GET_PROJECT_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
        ProjectDetailResponse projectDetailResponse = ProjectDetailResponse.fromJson(response.data);
        if (projectDetailResponse.returnCode!) {
          _v.onProjectDetailFetched(projectDetailResponse);
        } else {
          _v.onError(projectDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getRMDetails(BuildContext context, String bookingId) async {
    //check for internal token
     

    //check network
    if (!await NetworkCheck.check()) return;

        // (await AuthUser().getCurrentUser())!.userCredentials!.accountId;
    var body = {"bookingId": bookingId};

    apiController.post(EndPoints.GET_RM_DETAILS, body: body, headers: await Utility.header())
      ..then((response) {
        RmDetailResponse rmDetailResponse = RmDetailResponse.fromJson(response.data);
        if (rmDetailResponse.returnCode!) {
          _v.onRmDetailFetched(rmDetailResponse);
        } else {
          _v.onError(rmDetailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  // Future<void> getProfileDetailsNoLoader(BuildContext context) async {
  //   //check network
  //   if (!await NetworkCheck.check()) return;
  //
  //   String? accountId = "0013C00000rWwiDQAS";
  //       // (await AuthUser().getCurrentUser())?.userCredentials?.accountId;
  //
  //   var body = {"AccountID": accountId??""};
  //   apiController.post(EndPoints.GET_PROFILE_DETAIL, body: body, headers: await Utility.header())
  //     ..then((response) {
  //       ProfileDetailResponse profileDetailResponse = ProfileDetailResponse.fromJson(response.data);
  //       if (profileDetailResponse.returnCode!) {
  //         _v.onProfileDetailsFetched(profileDetailResponse);
  //       } else {
  //         _v.onError(profileDetailResponse.message);
  //       }
  //     })
  //     ..catchError((error) {
  //       ApiErrorParser.getResult(error, _v);
  //     });
  // }
}
