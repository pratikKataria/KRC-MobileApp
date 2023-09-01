import 'package:flutter/cupertino.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/profile/model/profile_upload_response.dart';
import 'package:krc/ui/uploadTDS/model/upload_tds_request.dart';
import 'package:krc/ui/uploadTDS/upload_ds_view.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

class UploadTdsPresenter extends BasePresenter {
  UploadTDSView _profileView;

  UploadTdsPresenter(this._profileView) : super(_profileView);

  void uploadTdsDocument(BuildContext context, UploadTdsRequest request) async {
    //check network
    if (!await NetworkCheck.check()) return;

    //Add Booking id to request
    request.bookingID = currentBookingDetailController.value?.bookingId ?? "";

    Dialogs.showLoader(context, "Uploading tds details ...");
    apiController.post(EndPoints.POST_TDS_DOC, body: request.toJson(), headers: await Utility.header())
      ..then((response) async {
        await Dialogs.hideLoader();
        ProfileUploadResponse profileUploadResponse = ProfileUploadResponse.fromJson(response.data);
        if (profileUploadResponse.returnCode!) {
          _profileView.onTdsUploaded();
        } else {
          _profileView.onError(profileUploadResponse.message);
        }
      })
      ..catchError((error) async {
        await Dialogs.hideLoader();
        ApiErrorParser.getResult(error, _profileView);
      });
  }
}
