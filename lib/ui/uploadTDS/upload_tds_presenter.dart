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

    if (request.acknowledgementNumber?.isEmpty ?? false) {
      _profileView.onError("Please enter acknowledgment number");
      return;
    }
    if (request.comments?.isEmpty ?? false) {
      _profileView.onError("Please enter comment");
      return;
    }
    if (request.tdsAmount?.isEmpty ?? false) {
      _profileView.onError("Please enter TDS amount");
      return;
    }
    if (request.totalTransaction?.isEmpty ?? false) {
      _profileView.onError("Please enter total transaction");
      return;
    }
    if (request.fYYear?.isEmpty ?? false) {
      _profileView.onError("Please enter assessment year");
      return;
    }
    if (request.transactionDate?.isEmpty ?? false) {
      _profileView.onError("Please select transaction date");
      return;
    }

    request.bookingID = currentBookingDetailController.value?.bookingId;

    Dialogs.showLoader(context, "Uploading tds details ...");
    apiController.post(EndPoints.POST_TDS_DOC, body: request.toJson(), headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProfileUploadResponse profileUploadResponse = ProfileUploadResponse.fromJson(response.data);
        if (profileUploadResponse.returnCode!) {
          _profileView.onTdsUploaded();
        } else {
          _profileView.onError(profileUploadResponse.message);
        }
      })
      ..catchError((error) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(error, _profileView);
      });
  }
}
